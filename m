Return-Path: <johanneskauffmann@hotmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A58CAC592
	for <webhook@archiver.kernel.org>; Mon, 22 Sep 2025 07:47:57 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [52.103.46.77])
 by mx.groups.io with SMTP id smtpd.web10.46188.1758527267626788610
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Sep 2025 00:47:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@hotmail.com header.s=selector1 header.b=mZzeGW2M;
 spf=pass (domain: hotmail.com, ip: 52.103.46.77, mailfrom: johanneskauffmann@hotmail.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrIjxM2gZ8Zb/SRnMdHsdcaUcNR94eLd+j2E0aO+ipW0PkuolCEchgn1asEb2QKCYslZqSzSqE0aoeH8dCydgf5b2nwbe9ZR1i4DMT/hMkn3/geZUrVP3mzv6Z36eC3/6Ad04k50t+SaXc52QGlKdlmhBqDivPH9r+uvCxxn+SoTaJSv9s/WLwKhp9WlVfv8Jn/LCI7h2+Vi9KjesOiaWh5cyJ7n0aYwNlkRQDF0gVXFxiwivbrYJJnf3COPKx7j2t90ZaCZg6ILSulba0X2KcSbQt+rcyJGUlw2av+szq7j0A/oWiVNADPVZ+EMDt5vbZyR4jf6kva0AF8rzI9GOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVBz7ZZHmkHOyygzARhGE3oUQBTjonY4C+yEsN06ulE=;
 b=HsVTMh70Y2REEREyUPw1BgYiTz7Bf2CcdtsSlbm2f+QbGoJHTtimUfecdsbewEBkT0wgdsDbNWXjjFd0lsVbiO6jmZ3EEbJuWLq/XGVzMBU0/ffpnz3YNJft12j07gHDF4Qwb/jY8Ws57SbSS4zRClcBqXGP7e7mCHC0X9jcYUufOAF/QQAOemxB82aNwbeJxQwgHf+hrghIWQ96xP+SgDAZfJETiMM6d66RkgYaNDXHm6Zs4aHgyiiXz9PBrdg68YANoYYZoKefWT+ZhRc+yqihRsRvB8aQaedZ9ORo7dLT6XqeAUE72qHrhzy9BcD81JJQO8BzSOu55L2LJsOnIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVBz7ZZHmkHOyygzARhGE3oUQBTjonY4C+yEsN06ulE=;
 b=mZzeGW2MS5AWSPrVkta3x3ZzubzcDCKq0LF6vPKvvcX7Xsenc9ReVEFPVpyU7RgaW9ooqvGoQebdl5JzvyclWLv2kSGVK73Jqxo8aKBBalcU57wwGCdbRu5DzFNSHvccOxisA/J3ZjpSEJtmzdA8qjU3Jpzk+wXXFH9A2H24o7ptzeAYgE62OiXD8jlBtgmAmikq6Ao2BPVsWDs1vT4DvxyO6+sZusht/L1Qb08FRavMTPzl5LYfCXLsHfHGp5BeCtN6vAL1ldMdQ2S2QLf6toNYuIzNn1vkhqsVPjRGjcQD1JxncfLswo1bJ0MmX+AaATvMD3Pj953ZAVKxJHF4ww==
Received: from AM0PR02MB5764.eurprd02.prod.outlook.com (2603:10a6:208:18d::22)
 by AS8PR02MB9434.eurprd02.prod.outlook.com (2603:10a6:20b:5a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Mon, 22 Sep
 2025 07:47:44 +0000
Received: from AM0PR02MB5764.eurprd02.prod.outlook.com
 ([fe80::5b5c:aeb7:184f:e2b2]) by AM0PR02MB5764.eurprd02.prod.outlook.com
 ([fe80::5b5c:aeb7:184f:e2b2%6]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 07:47:44 +0000
Message-ID: 
 <AM0PR02MB576490C2267B6F4B73E297DAA612A@AM0PR02MB5764.eurprd02.prod.outlook.com>
Date: Mon, 22 Sep 2025 09:47:43 +0200
User-Agent: Mozilla Thunderbird
Content-Language: nl-NL
To: bitbake-devel@lists.openembedded.org
From: Johannes Kauffmann <johanneskauffmann@hotmail.com>
Subject: [PATCH] fetch2/repo: add support for fetching submodules
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0025.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::14) To AM0PR02MB5764.eurprd02.prod.outlook.com
 (2603:10a6:208:18d::22)
X-Microsoft-Original-Message-ID: 
 <ad60a45e-6edd-4cdc-97fb-3487f2a4f3a1@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB5764:EE_|AS8PR02MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: c6aa0bac-b4ae-43d5-ef74-08ddf9ac5071
X-Microsoft-Antispam: 
	BCL:0;ARA:14566002|5062599005|8060799015|19110799012|6090799003|23021999003|15080799012|5072599009|461199028|440099028|51005399003|39105399003|40105399003|3412199025;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dEpveWFRbGJ1QXFNeW5TSWRHVTVnTjQ2aGNoQXI4YzlvTElLa3pxdjlPTExN?=
 =?utf-8?B?c2MxdWpyZUlPZzNoQ0Q1cVlhZjlHRS9zTG11MW56MnZjRkVCSVlWeFQrOVp0?=
 =?utf-8?B?cHF5dFNMWHFMSFBOQ3R3aU42elZZMW92SlV1bjc0WHFJdlc0N2dVb3F3Lzkv?=
 =?utf-8?B?dEpHMkxqanJhLzZYaWJnVW5kSWRYVytQdnlkWFRvbUUwQzJvazEyTGk0Ymh4?=
 =?utf-8?B?b1lPMlp4L1l5VzZvV25lVGxYcGpvMmVoMjlVQS9Na0s5bEZJb3ZwZ3h2UkNj?=
 =?utf-8?B?MVZDQWMveVBhT0w2anBjMzh1Kyt0ZnJhTlhHdGxwQlcwT00zUTIvQ3d2T29a?=
 =?utf-8?B?OHNSTysvakUveC8wQU12SWMvS1hBQW9NcGNFZEVxZlVYWE01TTYzelpObWRE?=
 =?utf-8?B?cW1ETHpEazY1c3JjWHgzYWdZSVZBTTVIaDhONW1YZWhaQnlqbnBBeWNTcVlw?=
 =?utf-8?B?NXJrNmtsRkFrVU5QRE12ZDB4Q1dYSVVTOEN3LzZPOUV5SWhjbU56UUtTZ2pa?=
 =?utf-8?B?MlJmQnMzcVUrcjd0Qittd2VuOU8zRzBnR3BIQi9YakdRU3l4cmJqdjA5MWJ3?=
 =?utf-8?B?WjdpSkJUUW15a0VPNit0V0VqK0ZmWDZNVzA2TDFHWllmOGg2MUk0RUlEbDdl?=
 =?utf-8?B?bnM5VmNvd1RKUWo3aE40OWUwUFplYW8rVEJHaFBoQXZFZ1VkM1NDaytnQXZj?=
 =?utf-8?B?WkpTRVMwT0VMTEFWdU9xdXVta2FGSXQxbFhUSks5YzlXMWJoaE9TUk5VMHds?=
 =?utf-8?B?NnZ6M1ZRQnpuWVZRampPWFJ2ZC9QT0doZXJyeHhJUWhiaUtjWjlTYytOMTdl?=
 =?utf-8?B?cEUzaHlCb2t4cW9CZ1FLWFYwTVMrTGVDWWFpY0IvaGFKUGpRY0FaUWQxd3hy?=
 =?utf-8?B?OGhib244eW1sRUtzSFBPT3ZmZTZhRnBnK1RDbkp4a2lGa3VtNWhJenZRUWFm?=
 =?utf-8?B?KzhreVlvYStxQkV1ZXJEd2o1MTdTSG0zaWZlMGJORXMzWExBbHlWVUZ6ZHdu?=
 =?utf-8?B?SjdUY21nenlOQlQ3QktzRThtb3lsRnpjaU1kNlBUREpITm81SEU0dHhvY2tn?=
 =?utf-8?B?amF4QjRqS0Rtc1VPdk1LUCt4TlVZL2llZHVJZzhpaWd6bHY1cEJCMDEvTDBO?=
 =?utf-8?B?MGtNU1g5aDROT2JzdVA1akJsSy9ueEdQTHhZeTVHd2ZxTVVGaVUxRXl3RGhu?=
 =?utf-8?B?TU9HT0puelRXdDRFTnUrOHc3SWVzNStQeGFPdGRmRm5sVmY4SHp1MHBBS0N5?=
 =?utf-8?B?TE5USjFnREZ2cHZtUEg1NGIwbDlNVkpMN0JHYzlmSFY4U3ZWVytxN0hCZm5x?=
 =?utf-8?B?cEduQjRCSzdFRXBnVHpMa1ByMktYLzAwcytESW1BdmY2K3IzeUN1TmRCcHZK?=
 =?utf-8?B?MU9iSHNqczdzSVh0Qmp1OHAycmNPQnpxSldqd1YyNGtNQS9PbUl1cU93NWN0?=
 =?utf-8?B?empoS3h2MWVwUjBjUGxKU1JNRHhuRWdHVW1zcGlwdUJTQkNkMmRrY2praUJO?=
 =?utf-8?B?dVY3a3hxUytqbnVlUmNFaFkxRkpaR0tGS01jSUc3QXp5Wk5PdjhwWkh0TFdv?=
 =?utf-8?B?bDlpcEF1ZDBsQzViNFFOOFAyaE16dVlPMHg5NUx0amxRanBGaW1FN2srV05B?=
 =?utf-8?B?Vjh1aDJYbnNGQVVzVEZFV2dlcTJRTmRtc0VRRGlCSVF3aWN2VlpkbHpUTFk4?=
 =?utf-8?B?Y0NhWlFMMjdrWlZWbVJjRks2S0dPUjRvQXZubTN4elB5TTA1ZjJhY3ZBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dWdYczR0OXYvcUtMamhkQ2N2bXBFM1B3dEJlNlBIb1NLeEtZL0hxUXRMdDE4?=
 =?utf-8?B?Q2Uvb3FwYWphWERIZUpMOTF5Q1QrVFNGWHlFT1M2Z1RQNDhxNUF6NUFqZ0NS?=
 =?utf-8?B?Q0J5S0d0eFZSdXE4a0tua0hJakFhVTRrSk1DZUV0ejA1MmxsQlRxNUdpM2Uv?=
 =?utf-8?B?bmJxMFZ3U3p5dkdQNHlHTjNRSXZCWDZncTJOU0svQ0hJYWNBaUdvWmdERTBJ?=
 =?utf-8?B?Q3hIQWpZTWcrbDMwS3dwdXVpY1ZTUndnUVpzZnJ5RmR1aWV2MkpJck9HaXp5?=
 =?utf-8?B?MldvMC9OQ3d1bzNVNW8vWlczS0pXSnZrdy9pUG5RSlgzekZ3QW5DcyswTCsy?=
 =?utf-8?B?Z1RqKzNjWXlSUjBidVhwbG5WakxPSHYwVE52QkJ0T1BEVlJoTmFXYjdUK1lQ?=
 =?utf-8?B?WU1vZGsrOW1KSzFWQ1pQSERWWlg3SDZiS3Y4b3dQTHBXb3k1OVlzckFSaE85?=
 =?utf-8?B?cGRyTU9EYlh3V3B5NzRyYkJ2OExQMHREYkdUS01iYnpTTGV4allGckw0anpD?=
 =?utf-8?B?UFdkM1NmVnh2V0kxaUNkdkpMUWI3TXlzT2U4bGpsSkJyU25zYmprZENteDVW?=
 =?utf-8?B?MkNGNzYxekFoNE1tK1QzejlXT04vWTFGM3o1bHJUS1h3NHR0VUZpV1lKU3ZY?=
 =?utf-8?B?MEE4SlhaZG1TMWhOQUZzd1Z6d2JlRXU4K0NIY3hDdUVSbnFsUzJzdWY5cXg3?=
 =?utf-8?B?UUJYN0FFNHN4a3BiMzRyVEg2M3lzN1dOd1pHbzJJSDdUMDlyNmFIc2xNVURX?=
 =?utf-8?B?b2NVQ2I4Z01UZEZtSWRIU0RaNXhoZ1VpanlxTCsxTG5KQmY1T3ZUazhoODI3?=
 =?utf-8?B?N0ViaGZ0OWxIZXhkOE04UUJzQUlIdEFxZVdpbzJma3Z5MDI0RmxZM2FTRlRK?=
 =?utf-8?B?QVJWc2V6MGlTakx0ODVSaE1yaFY4VmwrRSt3L0VvdU05blBxbVFTMDVJblZR?=
 =?utf-8?B?U2dqeVE5WkNaQkVwN084dnoxTGZ5MWNadkxPbW81M1R5SmRQWHJvMWxCRGNG?=
 =?utf-8?B?cGl1OHFiMG1nemdScTRJcEdKdjQvTnc5UnYwUFNldnJNNDJjSzBzemp3QkxT?=
 =?utf-8?B?YjNBc0d1UWJ0WGtTbnd1S2RHUkh3VVJqTjRhNmNIUjRCekwrMVZESXJNTTdn?=
 =?utf-8?B?a2dxYWI1akdZTjZ6N0ZQbjFLYWEyNy9jMW01aXhIY3J3WlhOVmczUE5IRUVy?=
 =?utf-8?B?QlNCTDFkY0lTNGRQZUxySWRUTUJBWUJzSjNVaXh1MGJpd3BUcGJHQzA5WEhy?=
 =?utf-8?B?UXlFV21RMkxZZE5vZnNJLytyNi9mYWtlMU1VUW9Xc0YvZGxoVENDaXFNUG5R?=
 =?utf-8?B?M3JIRnJpd3lEMURNUEhCQXZ6NDVaMDJ3MlpkQXE3RGs3c0cxT09KMW5nNTRR?=
 =?utf-8?B?anVJRFNOYXpCRHR3eDQ0cTZ5UEtHZmtReFU3ZHZza1FCWUx6bmRiU3p4MUlz?=
 =?utf-8?B?bGY2b3h0WTNwTXhtS3hNVE5tUXZsV0pkQStiRmdpZTFDdHE3Z1cydGtJVFZU?=
 =?utf-8?B?cDNEY0tudDcvQlExVHFTM2dtellvdUVXV1lzVnloVXFKMmF0V2ZYNldvV2x5?=
 =?utf-8?B?SVFCZnpzRVh5SG9icys3dDdkdVRtTmo4V21sTnlQWDhVaFYzYnBvbTMyQjNU?=
 =?utf-8?B?UDFSd2lxTW1abWpJblZOQ0ZvQ2c1eVpmSTZyRVh0Y2MwN1A3L041ZFpjZ3NG?=
 =?utf-8?B?NlByQkJyemI5RmgwbE0vWWJTc2RnYmRBU2t0aldsaGdleXkvVjFvMERRPT0=?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-5faa0.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c6aa0bac-b4ae-43d5-ef74-08ddf9ac5071
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB5764.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 07:47:44.1380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9434
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Sep 2025 07:47:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18065

Add the fetch_submodules parameter, which allows fetching submodules of
projects by passing the --fetch-submodules option to repo sync.

Signed-off-by: Johannes Kauffmann <johanneskauffmann@hotmail.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 4 +++-
 lib/bb/fetch2/repo.py                                    | 9 +++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index f357765b7..e1781085f 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -658,10 +658,12 @@ This fetcher supports the following parameters:

 -  *"manifest":* Name of the manifest file (default: ``default.xml``).

+-  *"fetch_submodules":* Whether to fetch Git submodules of a project on the server (default: ``0``).
+
 Here are some example URLs::

    SRC_URI = "repo://REPOROOT;protocol=git;branch=some_branch;manifest=my_manifest.xml"
-   SRC_URI = "repo://REPOROOT;protocol=file;branch=some_branch;manifest=my_manifest.xml"
+   SRC_URI = "repo://REPOROOT;protocol=file;branch=some_branch;manifest=my_manifest.xml;fetch_submodules=1"

 .. _az-fetcher:

diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py
index fa4cb8149..de01bcb66 100644
--- a/lib/bb/fetch2/repo.py
+++ b/lib/bb/fetch2/repo.py
@@ -38,6 +38,7 @@ class Repo(FetchMethod):
         ud.proto = ud.parm.get('protocol', 'git')
         ud.branch = ud.parm.get('branch', 'master')
         ud.manifest = ud.parm.get('manifest', 'default.xml')
+        ud.fetch_submodules = ud.parm.get('fetch_submodules', '0') == '1'
         if not ud.manifest.endswith('.xml'):
             ud.manifest += '.xml'

@@ -65,8 +66,12 @@ class Repo(FetchMethod):
             bb.fetch2.check_network_access(d, "%s init -m %s -b %s -u %s://%s%s%s" % (ud.basecmd, ud.manifest, ud.branch, ud.proto, username, ud.host, ud.path), ud.url)
             runfetchcmd("%s init -m %s -b %s -u %s://%s%s%s" % (ud.basecmd, ud.manifest, ud.branch, ud.proto, username, ud.host, ud.path), d, workdir=repodir)

-        bb.fetch2.check_network_access(d, "%s sync %s" % (ud.basecmd, ud.url), ud.url)
-        runfetchcmd("%s sync" % ud.basecmd, d, workdir=repodir)
+        sync_cmd = "sync"
+        if ud.fetch_submodules:
+            sync_cmd = "%s --fetch-submodules" % sync_cmd
+
+        bb.fetch2.check_network_access(d, "%s %s %s" % (ud.basecmd, sync_cmd, ud.url), ud.url)
+        runfetchcmd("%s %s" % (ud.basecmd, sync_cmd), d, workdir=repodir)

         scmdata = ud.parm.get("scmdata", "")
         if scmdata == "keep":
-- 
2.43.0


