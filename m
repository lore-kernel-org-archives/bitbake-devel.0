Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CF2C77B7C
	for <webhook@archiver.kernel.org>; Wed, 10 May 2023 03:16:56 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.8025.1683688614671739481
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 May 2023 20:16:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=Wu+TrI7Y;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=4494f80ab0=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34A30YhE014139
	for <bitbake-devel@lists.openembedded.org>; Wed, 10 May 2023 03:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=GiYkedtEBBArzlspvJRXhI+HJsOrZ/w+jk0wmhDRId8=;
 b=Wu+TrI7Ydhbj8e5uzDS0zmquCxT8F+afnbXGRaq8WXrIvLNhSNOExEfiCHIA0G9dYfYE
 phNW1P6qDIUHk4zrh8Ul5p+WVsSn6G8Vzwe7OFhAg0XnHnI+gXnh7bqkwj7ONnI057RC
 Htkb+AXglCNc50oDkyCavFz1OLypDVog0UK/iQw/BHRX0teNuZBbz4TglTQPWuN/VElU
 ZDrrMzsjIERikstH1OEeopRR4IOxLcLgcLLqcAATwSU078C2X2wn9IiVycIvAid4guck
 mXnS/D1AftlVn9xCAQGYTr6GYWE5dqafDvnXr50IaKxxHm9JjXcIqXOpUGZXgWrJV+hs PA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3qf82x1af9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 10 May 2023 03:16:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHkJtR67NjT8rgw8QK0COaNw/vSSoSy2eG1HLNbkCXqbRqdgCS8U4uobdJgNmzum0Keps3asprc7qPb4Ehcq2aSDHAqo7hWXTIquRASi+Rvbg+RCsxZsanzwc0/F920FAVWX4qXDaF3PEoqF5QxPrKy5qVj6Z0nYXR/8SpUKiHp5UjP0ncRApa0vL79sF8VzLBXaNTkN4it6mAiIfOz+LQUqHLXtqv6fAwz4IZ4J64S16NimuhL96WUq4aWk9clBHsembfxY9dAnADqkNeqPeFar7BYPJnbtJsIBlRD3kpsQfOmbopaRQWXDzODvgZfuHcUazsHVumkOFB3r07PqdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiYkedtEBBArzlspvJRXhI+HJsOrZ/w+jk0wmhDRId8=;
 b=mptjahv8b3Q0Mn1S4yP6yFn+0EHu8xBosB06Kg4jnp1UO/aDfjYkoYXplQkgWAA6qjRmmZ8GCRvZqixjUZusDc/2glfq+PwvqPAnpEHdje4HgLSupYfg47/2TcNoDK4X+zMCLLkJrdwC7/Kn9N7MgsSUt+nFMQ5Ei3CjbQ5rgUdTMTj5DpwczH1K7HqDxZZxJ350gGdzrNyIdvYFE/l6j4UgDaD7CwunGFYnJ5CCnWamqQ35dDmYeh9BEu/z8nk8LXrr9rG+jjG4BY927+bwN6JPDcUKiZqBVr+X0r74JvfCny7/7f220tyMRlA5ACvWeZpajBb+i0IxAOHPoyG7YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by PH7PR11MB8060.namprd11.prod.outlook.com (2603:10b6:510:24f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 03:16:49 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::fa8:8cc5:a5da:7e07]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::fa8:8cc5:a5da:7e07%5]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 03:16:48 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel][PATCH] bitbake: add --noreply-timeout option
Date: Wed, 10 May 2023 11:16:31 +0800
Message-Id: <20230510031631.1813338-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0002.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::7) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|PH7PR11MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d67271-d059-4d91-5189-08db5104fe04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	r+rC5iICataDyC5kw1i+AFGxVtM8CxZ5Zmh+AYp8mH4isz1Iy88mXtHbhZ/I9MO/89WDPaUEoRvYMr7kxp8W/KDcrPgYb1t1kk+0eKbyOx1h7wlDtn3qJEl4YGqhsrvK7F8q8Ts8kSlGYEQtDbWytuV3vHitcfoND3vTq5UC3O6FsuDrQz3Nof0NmAdjZuMCzIsX4420KpYJSyZRvUQJWAkwU0w4ySDVYzN7tsLvH22Ugr9GXNb1owclzUCY/Xy1so0b0/1wjWLoSRMkWFlHEFJtkOx8xSPBrFJAQDjwUxkRYmIjQvC4NPHzEUuO1FfZCIBcmtcisFiXkVjCuYdoCqf4zlH0Gmeb/Qm1RdbcjWLWxncoo/0zoldmdeVG2FI1dC/Cm8l51WgfKsI/RP2bmPJvgD3M/hDjcazlXs4rbfEWqE1Rvu1UgDdPlygzUxgYnybweb6HxBoK1J1iKXk8f12mBdfUFekfsW+iFlxvFY1q82cvWyll38v5j8psd+03pz0NrpdRVIc0DaMOlspIjfYBW2H76Kq/nInGvE50Ks3KdX5/Cxz4vDPserZw7VRmgZrKgmOJD+dQ4t7ZAT2iemDd1ippXw3qCpp30t5maMSNhv6lWTgdRxCBoN5y6h8pdFp/uwW6vbd/uQJnMylGOg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39850400004)(376002)(346002)(396003)(451199021)(316002)(52116002)(83380400001)(6916009)(36756003)(5660300002)(2906002)(41300700001)(66946007)(66476007)(66556008)(86362001)(6486002)(6666004)(1076003)(26005)(6512007)(6506007)(38100700002)(38350700002)(9686003)(2616005)(8936002)(8676002)(186003)(478600001)(334744004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BrANXIJJQWXec3qiwZh5O8UrVNWu3k6/ravbOots16c8h5FxPCRIbD1zDfg1?=
 =?us-ascii?Q?i5OTXLv8KAStvXEo3rnjkHcv18cc+rspgO5yPBtSBxJ6UYyv8J7zGtgu7ZL9?=
 =?us-ascii?Q?eu0VlFqIEf7VUt8B6U/HJ06r+trH2RBSK0c5jUza+1yigMapRcqXBhtprw4j?=
 =?us-ascii?Q?vhU3/eU2ZRQYL7HmzVus7w8UnsLzIEofFjy/GEXBhKYBQoEp7AnJFLFvXYf2?=
 =?us-ascii?Q?EUMm48jpahbVKr9guN4V81ItVTm7sSrLq6yXHbEWuCsijq/L+6ocCt6NoWi8?=
 =?us-ascii?Q?wbxhetFSywXCNHvdvvs0vmalNI5lWq67vLVxa7onCA+p14HYKYaTuTz+1lU/?=
 =?us-ascii?Q?Hrb/EcmYlvRRjlCIx539DEQqOKc+0LR5g7v/4WlZ5KnI9nNFjICFb7KVEtd4?=
 =?us-ascii?Q?HlofF2AniSCWMTJ089d1zwb71hHhYUuleQUNA4rTx5jdYbaxJUxqTJUcoiul?=
 =?us-ascii?Q?pxv3gg2DSZ4SCfIYKEmjBUX+7WHAQuFezea9IJPVU5jqN8tlPV/Ph8rOD0B4?=
 =?us-ascii?Q?kutm4gBT9GRb+ZmrVdAKXuUAUELC4IuyTDqP802rfK7M5qYbKZF/SUltu5fG?=
 =?us-ascii?Q?C3zmfCtzlsuMMDZJ4ivCMpsMdPSTaq9aj5l9DOQ2Lok/E1vqYYTn0GQAk3df?=
 =?us-ascii?Q?UfSvaMUWDhps43tG7RgHbKiN4SO0C7eMOqqPnc/5GAxFCwk+RrG/LTLc0u1i?=
 =?us-ascii?Q?lKtC3tcnz+Y06EHLvv1usJ48CWuFi6FFG9Dq7M2Ko6c8RDceEwgwO2v7vT0M?=
 =?us-ascii?Q?3KDHwAw8b3tlJXYK28uzLGwCh2RoshLzZXZ/HCzBPyIM0elK9ycnuVxzOWdl?=
 =?us-ascii?Q?PlpjnPgYnWTWVfTGD/IXLfztfhlKzcECcwa68jKpM+ABxCDTfNB9zl9IEnRb?=
 =?us-ascii?Q?rCTJ/xI7YqNgyYtJ6UZIocBdjWTGMkupoD1MXUmizEignX3rphVnTr2FIzGq?=
 =?us-ascii?Q?LcDXfxexdU/71z4w8wiyGGY2XVIx5KbaTy2n9LsZE8qDy5NxjiiQy/PRRsRK?=
 =?us-ascii?Q?7VgczF2srkIw/A/44EbzYHcMHnL7moEpRjxpR9OUX/EDWNxupPn/2BOTtTOz?=
 =?us-ascii?Q?sLsYQcCcweCfjtsnbMk5uFsKd3DFbDth+9PbOBis6DlZvVy4nIODffDjbIuH?=
 =?us-ascii?Q?QlG450zYXMwNVyPZb99Xcs4afBpLkYL/3xooRUpp1uViYdIesrezAve7UW2K?=
 =?us-ascii?Q?wsLVHZReX1FAfq4PNtFLzO1yTkByk1F3PUjOCVhf5fsuKIQz8irChhi3KTy/?=
 =?us-ascii?Q?sGf+IBgNmE7ITWWmoddR6Qz2Rtd7ay2hdk92HklmQ01zQKIREjlMp/sOViBv?=
 =?us-ascii?Q?Y1+69yCs9g4brOtdeuWfI9Sw5yVzIFYoQnI6lETJSkV74WK5NYMfBy7sc8mI?=
 =?us-ascii?Q?0p7qfaLoVDP7ymgiDNhmRTPaTg5mNqhzZH42RiEq/jzitODDyzENLjFo3P35?=
 =?us-ascii?Q?c2OBqUmGYXuo5PcgjkxJ11lENwID1YKhrg1gdjSrPqct8rFDsOeDIa8G6hwr?=
 =?us-ascii?Q?sXg8Ps/2XW5Ch/v9DkgykQ9pgU2a3HuVXxmAecumZ3V8S+zyM5lkvfLqUnC0?=
 =?us-ascii?Q?CIoHKWZVVHtuvZKFqLM+QzujD6Q1J4ZaDiwctm/z?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d67271-d059-4d91-5189-08db5104fe04
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 03:16:48.8339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olVKYp1EaTcI89C49rVF987b63Tq8SYX54n18mn/JHrk2dYs9xY0QG1xXj5O3isJS22gY3RiJuuKIV+rK3L9zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8060
X-Proofpoint-ORIG-GUID: Npn88UKvqDk-CJcqXNRlwamEUjLH212P
X-Proofpoint-GUID: Npn88UKvqDk-CJcqXNRlwamEUjLH212P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_16,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 spamscore=0
 phishscore=0 mlxscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305100023
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 May 2023 03:16:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14772

From: Chen Qi <Qi.Chen@windriver.com>

For now, if the client gets no reply from server when running a
command, it exits after a period of time. The value is currently
60s. Looking at the history, this value was increased from 8s to
30s, and then it was increased again to 60s.

For now, what I can see is that when running one world build on a
128 core, 512G server, starting a second build has a chance to fail
at updateConfig.

Instead of increasing this value again and again, let's add an option
for easier customization of this value.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 bitbake/lib/bb/main.py           |  7 ++++++-
 bitbake/lib/bb/server/process.py | 19 ++++++++++---------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index 92d8dc0293..47c000b03e 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -267,6 +267,11 @@ def create_bitbake_parser():
                              "set to -1 means no unload, "
                              "default: Environment variable BB_SERVER_TIMEOUT.")
 
+    server_group.add_argument("--noreply-timeout", type=int, dest="noreply_timeout",
+                        default=60,
+                        help="Set timeout to exit bitbake client due to no reply from bitbake server, "
+                             "default: 60s.")
+
     server_group.add_argument("--remote-server",
                         default=os.environ.get("BBSERVER"),
                         help="Connect to the specified server.")
@@ -484,7 +489,7 @@ def setup_bitbake(configParams, extrafeatures=None):
                             bb.utils.unlockfile(lock)
                         raise bb.server.process.ProcessTimeout("Bitbake still shutting down as socket exists but no lock?")
                 if not configParams.server_only:
-                    server_connection = bb.server.process.connectProcessServer(sockname, featureset)
+                    server_connection = bb.server.process.connectProcessServer(sockname, featureset, configParams.noreply_timeout)
 
                 if server_connection or configParams.server_only:
                     break
diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index db417c8428..8c7b6da64a 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -495,16 +495,17 @@ class ProcessServer():
 
 
 class ServerCommunicator():
-    def __init__(self, connection, recv):
+    def __init__(self, connection, recv, timeout):
         self.connection = connection
         self.recv = recv
+        self.timeout = timeout
 
     def runCommand(self, command):
         self.connection.send(command)
-        if not self.recv.poll(30):
-            logger.info("No reply from server in 30s")
-            if not self.recv.poll(30):
-                raise ProcessTimeout("Timeout while waiting for a reply from the bitbake server (60s)")
+        if not self.recv.poll(self.timeout / 2):
+            logger.info("No reply from server in %ss" % (self.timeout / 2))
+            if not self.recv.poll(self.timeout):
+                raise ProcessTimeout("Timeout while waiting for a reply from the bitbake server (%ss)" % self.timeout)
         ret, exc = self.recv.get()
         # Should probably turn all exceptions in exc back into exceptions?
         # For now, at least handle BBHandledException
@@ -531,8 +532,8 @@ class ServerCommunicator():
         return
 
 class BitBakeProcessServerConnection(object):
-    def __init__(self, ui_channel, recv, eq, sock):
-        self.connection = ServerCommunicator(ui_channel, recv)
+    def __init__(self, ui_channel, recv, eq, sock, timeout):
+        self.connection = ServerCommunicator(ui_channel, recv, timeout)
         self.events = eq
         # Save sock so it doesn't get gc'd for the life of our connection
         self.socket_connection = sock
@@ -666,7 +667,7 @@ def execServer(lockfd, readypipeinfd, lockname, sockname, server_timeout, xmlrpc
         sys.stdout.flush()
         sys.stderr.flush()
 
-def connectProcessServer(sockname, featureset):
+def connectProcessServer(sockname, featureset, timeout):
     # Connect to socket
     sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
     # AF_UNIX has path length issues so chdir here to workaround
@@ -704,7 +705,7 @@ def connectProcessServer(sockname, featureset):
 
         sendfds(sock, [writefd, readfd1, writefd2])
 
-        server_connection = BitBakeProcessServerConnection(command_chan, command_chan_recv, eq, sock)
+        server_connection = BitBakeProcessServerConnection(command_chan, command_chan_recv, eq, sock, timeout)
 
         # Close the ends of the pipes we won't use
         for i in [writefd, readfd1, writefd2]:
-- 
2.34.1


