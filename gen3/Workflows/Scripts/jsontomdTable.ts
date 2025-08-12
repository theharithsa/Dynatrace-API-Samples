// Dynatrace Workflow step (TypeScript)
// Input: { execution_id, previous_step_id?: string }
// - Reads JSON from ex.result(previous_step_id)
// - Normalizes to an array of objects
// - Builds a Markdown table string
// Output: payload.markdown (string)

import { execution } from "@dynatrace-sdk/automation-utils";

type RowObj = Record<string, any>;

export default async function ({
  execution_id,
  previous_step_id = "execute_dql_query_1",
}: {
  execution_id: string;
  previous_step_id?: string;
}) {
  const ex = await execution(execution_id);
  const prev = await ex.result(previous_step_id);

  // normalize to array of plain objects
  const items = toArray(prev);
  if (!items.length) {
    const markdown = "## Table\n\n(No data)";
    return { payload: { markdown } };
  }

  // infer columns from union of keys across all rows
  const columns = inferColumns(items);

  // build markdown table
  const header = `| ${columns.join(" | ")} |`;
  const sep = `| ${columns.map(() => "---").join(" | ")} |`;
  const lines = items.map((o) => {
    const cells = columns.map((k) => escapeCell(toCell(o[k])));
    return `| ${cells.join(" | ")} |`;
  });

  const markdown = ["## Table", "", header, sep, ...lines, ""].join("\n");
  return  markdown;
}

/* ------------ helpers ------------ */

function toArray(input: any): RowObj[] {
  if (!input) return [];
  if (Array.isArray(input)) return input.filter(isObj);
  if (Array.isArray(input?.records)) return input.records.filter(isObj);
  if (Array.isArray(input?.payload)) return input.payload.filter(isObj);
  if (Array.isArray(input?.data)) return input.data.filter(isObj);

  if (typeof input === "string") {
    try { return toArray(JSON.parse(input)); } catch { return []; }
  }
  return isObj(input) ? [input] : [];
}

function isObj(v: any): v is RowObj {
  return v && typeof v === "object" && !Array.isArray(v);
}

function inferColumns(items: RowObj[]): string[] {
  const set = new Set<string>();
  for (const o of items) for (const k of Object.keys(o || {})) set.add(k);
  return Array.from(set);
}

function toCell(v: any): string {
  if (v == null) return "";
  if (Array.isArray(v)) return v.map(toCell).join(", ");
  if (typeof v === "object") {
    try { return JSON.stringify(v); } catch { return String(v); }
  }
  return String(v);
}

function escapeCell(s: string): string {
  // keep markdown table intact (no pipes/newlines)
  return s.replace(/\|/g, "\\|").replace(/\r?\n/g, " ").trim();
}
