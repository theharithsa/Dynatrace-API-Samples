import { auditLogsClient, logsClient } from "@dynatrace-sdk/client-classic-environment-v2";

export default async function () {
  const PAGE_SIZE = 1000;
  const all: any[] = [];

  // 1) First page
  let page = await auditLogsClient.getLogs({
    from: "now-48h",
    pageSize: PAGE_SIZE,
  });

  if (Array.isArray(page.auditLogs)) {
    all.push(...page.auditLogs);
  }

  let next = page.nextPageKey ?? null;

  // 2) Follow nextPageKey
  while (next) {
    page = await auditLogsClient.getLogs({ nextPageKey: next });
    if (Array.isArray(page.auditLogs) && page.auditLogs.length) {
      all.push(...page.auditLogs);
    }
    next = page.nextPageKey ?? null;
  }

  // 3) If nothing, return early
  if (!all.length) {
    return { message: "No new logs found" };
  }

  // 4) Enrich each record with log.source
  const enriched = all.map((log: any) => ({
    ...log,
    "log.source": "auditLogs",
  }));

  // 5) Send to log ingest
  const data = await logsClient.storeLog({
    type: "application/json",
    body: enriched,
  });

  return {
    message: `Ingested ${enriched.length} audit logs`,
    response: data,
  };
}
