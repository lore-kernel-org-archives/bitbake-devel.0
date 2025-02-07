Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707D0C021A4
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 12:47:32 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.101])
 by mx.groups.io with SMTP id smtpd.web10.68438.1738932445099229225
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Feb 2025 04:47:27 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=WPNp8ZHq;
 spf=pass (domain: weidmueller.com, ip: 40.107.162.101, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgFbHPWJq8OrHnUI5AJz7Rf8MuTHM01iRZE6OFv0r6M9uPXYj9BTW0I06r9JDr7Iargp4l3pfDfqiWd3M94V2Js6dWEpP3ps8b4pNYe2m0tFJ6AXSKpu5egSvKT1J02VCTGdZocREEi26SL7VXRrhkZAEpcCkdXKNfMsPwjlQ/GqsmxITDdjYHXhSL9ph9waWosbI8yKEajY+leZX+XSJ/+UJdzRHeOfu8Mf5aOkMGqU9vwMKf2BbGXwE6/woQv1O3sOCdEuD6F+k93pK1ehjFFItNbr964RgidOTsv58av/QFAZcW1P/TJdm/VzrIww+GE0LwA/ZSmACBqRqATVWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SntXOgJbCG0W5B5/OHIqLpdYoNcRVMPi38tFtmH6LI=;
 b=fPzhsUVHM0q2Uf6tQ02STp2UGxn1IIBaUTWeAEG04tGouiy5bURC6Nf34h450tc+Q4oQ2AfQE5kS7jZKM8rpZ3nJBu4+FWrJoJcNQQyqUoc9TJiZQBKx4QT1uZkJSOl/Dm0DR3+uTckCko0d4gjGdnrPNFyPQeVpmmHX4pzqzLgH9r4mo+hPZ7GLrktD6Wlt2Yw5+Af/Sub0+gYYLnhvHqlWElnGZDVQh38lFemTpgjHPI3+RxuTEQv6x+JTGHhbj1NbJWB+R9meGNlf0KEtV5s26i+sPPnC6r51icPxtSSK4Wz2lrJ9+3l75XANZ18lQlyUQLlWIZ44DMNDzgXLDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SntXOgJbCG0W5B5/OHIqLpdYoNcRVMPi38tFtmH6LI=;
 b=WPNp8ZHqedrgni1IEmMJ1s+SIbFikBqPkTRY7cU5oZsfpm0FL+yD0P/TQN0mkn6nxw9VnGreQh19rgNExI490LVRAWfoVpTX//LdPHoyVqpSorfYxNbKiTtqM/wthEaSzXhh5CxjxeKcso1YZUOfsX9akV6rExk5PJwzmigsipFxL9GE1oy7VPxea57XCrZKNDBnODcZqV0ix2ZF5/k1F2SqXyiCD6jglIC2pjZksXHaY+eHUok6z+gTD3nY8cOpaIK4dZ2I4OuLVgnGFXGy+YzF5DI34jvkppYlusDPYO0KKFnvMHIYfaHAkgMXRyO14yIsc5ttFSZHSvy9MC5xvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by AS8PR08MB6390.eurprd08.prod.outlook.com (2603:10a6:20b:31b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 12:47:16 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 12:47:16 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 05/13] fetch2: remove duplicated code in url decode and encode
Date: Fri,  7 Feb 2025 13:46:53 +0100
Message-ID: <20250207124701.14787-5-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207124701.14787-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250207124701.14787-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::13) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|AS8PR08MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: c57d63db-f87b-4b63-f68e-08dd47758c1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?KAPUw4XcelKMWU5YEHIIkpAyWrGlI0/TpNeOXTWjcugP8vk/1d2ec/yC3Icb?=
 =?us-ascii?Q?VJj3Pyf0JZxuj9zzljMZJVB+t+z4VbRVsuR6bwtruWN0TuMlteSsZ8+UX+C6?=
 =?us-ascii?Q?WMqMddkKdkuVQBw2dRHVgS8v0Y/m094i+5P9qiwuhKzHl6rFyOXhKZCIIP4w?=
 =?us-ascii?Q?IORO/W9tC1FenLlBpTS4EWreAsqDceTJiJn7kCeTXnmlKQd2YndoABBGrwrk?=
 =?us-ascii?Q?nmFnLRVPM1m8GQ78DpeRp4jvj02IHLW0NBAcZR2yA6/OvZo6GOMskW+TsMmh?=
 =?us-ascii?Q?7JJ87YtxlGrh2HwNmwoScHMPgKyHIWUAu6uoqJHXnNIKkntgPGXvIin54P49?=
 =?us-ascii?Q?nSsjmafL6p440DgRvyIMwOLud2WiYI80VCryKuBR0Hb+OL4JnpVh8iCcJCsh?=
 =?us-ascii?Q?KxqklT0dhYV2cFXOOXGIj9Qt1MXtXK7jN7/PFXHkAVFfvwA/lfnDbRSR/47d?=
 =?us-ascii?Q?UOvoQfFT7FN6P7awH87dLnohJHmRWttvsNsgarrh4mgXNZfMnipV6sijsn1x?=
 =?us-ascii?Q?XU2EfMcU3HgDcGWN7Z+ZBpv++1HVdU0icBbLA+uToHf2K3YyNVJui+bz8e+C?=
 =?us-ascii?Q?dHBxar2L3/Oz6EUpTW2Qdq8iZgwgR6wQVbUILhJgOe7FGxIzz+nN7+RDz1Cx?=
 =?us-ascii?Q?JsaxFUOA+8mbDp44WjZyyw+ag2KRT0xdrbJmpXRMrMD86tkifHE9tFnAgQ3A?=
 =?us-ascii?Q?8R9XDoiqv26xtL7Khy16sPWjoPBBoQmx/fTX+U+mz1Bb9DOPByoWtLHm0fhv?=
 =?us-ascii?Q?KqTmEQjNd3V4AxbWQNiUq1ikx0vFQchDlgh+EMy5bccpOoRqt/c1orVeesCO?=
 =?us-ascii?Q?2J0fZ3AM8zLZUadtdF5KEeofRBv7bsjjOSRJ05cpkuszog3n6UvxXnx5Psi7?=
 =?us-ascii?Q?tDHmNLmRpAJeLBw4kIgedhdYvPvA4b09Axo8jKl4jNnfk/8Fru3wojkkrWKd?=
 =?us-ascii?Q?8iZikawfa0aYoFuRqRS6EjVWmsbPVCsWhHcA5lRNp/zpU0sRyiIHDsos6/vh?=
 =?us-ascii?Q?mY1IHdpLZ6GE3q+k+sryvdD8cWvnok57hZwyECQOD6FgeR0zTLAq8Q9yoRt5?=
 =?us-ascii?Q?xtmD0ryO4GWmmDMB52TqVlDQf4OxsbTELG9LRt37eTFzasqZQ5VAzOkTkc6L?=
 =?us-ascii?Q?7vMatmcZC6iTYOOUYT9CpPLSQRbBciGklEqm945zYpa7H2pbTLh3+O7ykxiF?=
 =?us-ascii?Q?SN4zs7LFH5pczmAweM8CbaWtmWvhguK7h0fMBxw37JgkSL+KhTmGr3NF5ql0?=
 =?us-ascii?Q?NrOXDppzi16AcrzeYlMCxPVhls/fqhhQJH2AiRgR0bjUDKLwmnG01JmwBoVI?=
 =?us-ascii?Q?+Tw6ocgK6h4x7Ubj+Lkt0RXIr7YvFAnYmoZJk3qppEwxo80GilUi6SafBb6l?=
 =?us-ascii?Q?5wBS1lBezzh5rnu3x7y7hTQRwMBy5VwYYfM1mfSZucDxiI40PBQVHXrMsebq?=
 =?us-ascii?Q?+yvzbvqHic7QU8PrmI0WbNU+XHG05aUC?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?itPPwik2tLwOXgjzhmoJsKfI2uoUhFLLAV4r7qe3iTpxrOPGUpys4qIvSXam?=
 =?us-ascii?Q?YE9VkIT2gmgc81H2+WtfYq3zd0ur470cPnE9y/CTDtdaASKdTg4gyXQUp8l5?=
 =?us-ascii?Q?eDOjvGnxVR89WTSu80Et+OiqLlsEQFlsIXSF3Tgfcpi/JVluSc/49dBnWwnX?=
 =?us-ascii?Q?VLA8OpSMtlipMZpFDBNQvCEVccCo/VnGRjynsL65w2ef9Yyqe9Xf3Ca7PL1T?=
 =?us-ascii?Q?i7vPpwkn5qwI4xSEU4y+SfXud4f9dGtgGUL1ZrHp+fo8sZ3qXFuAv20+qt/Z?=
 =?us-ascii?Q?ZHmtw9eBp35kcSd4Ag+9Wt0j0shiEBMGC+qB1bmxOO3+tn3yGYdzm+tdKdx4?=
 =?us-ascii?Q?wmqyOHr67iPap2mugCHnaUNMblUCQBDp+xgJZui7hOlohLG/CF6CLUBwv8YY?=
 =?us-ascii?Q?PDQRuOI3HKldBdps1VbGYR83JHou7dX6aRTFQvSRdLM6RksV+tDSxWxlYN/L?=
 =?us-ascii?Q?tz++rsRNIDS+QBvQPvkaEnXUDqYU1n1ZEGFFUFhg11QsAw5x3j4bpggpysFd?=
 =?us-ascii?Q?8AH3v/XTKQtSAklBUHUdHxSo2174eDv4gU5V4KAB6aiysXkRwfCAED5L9Hpu?=
 =?us-ascii?Q?HrfS62hxqQowFnsvIEvYHZtIcYdoXPmPrglugHPUFrUxubsTmj4GXUQm6f+s?=
 =?us-ascii?Q?KQkzyWwUcQoWu6Ffvj2tu2bybQFxOVgg4tNqhqs4AkMLJPvuB1Zlg1SAliq5?=
 =?us-ascii?Q?LwmhpwqHfdpkLWq1Dgo3iURhERgVgi3Kloxr4BKcyeUFCt3FIk+0O0aK/vck?=
 =?us-ascii?Q?2jWxexRBkcpih/3WRrV8+5C1skLLifpyxiCvyn2wm2Jb3tJ5P/3JmKC/c66W?=
 =?us-ascii?Q?XpnSmv9xWPNuheEKtwPlk+khQo33jrBINfDlV86Wh8UymvGadyVUOKyGvWVs?=
 =?us-ascii?Q?lnnh0DiCM75s6uDRyfbQmxZIwIrolEa86zITveJfeY78qoE0gOMRBC/aSV7q?=
 =?us-ascii?Q?QLJ+Mwy0rSHFjStW0tDWdAquXBJvpeDpHLY0FVZp7GzkmdeZfkefBA/hZ49k?=
 =?us-ascii?Q?gk0gvVHA4QxvpB2Kim1nzYI9fV7ELO4jzA/yF4dcW9UC/YBVR7Obx89jrsZu?=
 =?us-ascii?Q?sti6xt48w343QfuGiqA9cI6pcqMRkVCxYPfOaI8LuYc+gjQRt+M1n5DmS7wQ?=
 =?us-ascii?Q?Li6x9pvVnWMHDztv4RAP1iZB1vhGTcqliCx73F3/BEwfoS6vIJPMCfv5EtNb?=
 =?us-ascii?Q?YxElvVatmDZFF9oYZUpq9Rua8AKXA6DLmyDn1pNtpitbvnlooEKgnWrVQM+g?=
 =?us-ascii?Q?hYDZNqg56mBNNN3pcyGHHakXs/fs7+4LLiMN1AUxRBbduWDDK6lQxB+VwBx8?=
 =?us-ascii?Q?zLgvXqFZ3Fu8e5BycpIo5GDz3CG6F/3KCDbUwCC7gfXd9CQtBg19thDwWgTG?=
 =?us-ascii?Q?MVyVSIFs71/hmuT1tGLA7NWxSW8oU5eQ2JMU2KOJWn8uhh4kNj0rIsP0WlxJ?=
 =?us-ascii?Q?QuszL0b/AYidFeed/Nio+R6nLNMw8W8oflDgXEo9gy13PPkFEtBJzfR4VmX6?=
 =?us-ascii?Q?pNmCHcVZ1fMuo6mJEH6FnxJfv/B6OjwZHFpKevsCDzgzg6pBDLjgYXbMMs/p?=
 =?us-ascii?Q?CUo8X5YZrY/T/XpVQgZEBvjsviyKJzgC2LmSJgkMpqdjEX2v85R+ex0ke/yP?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c57d63db-f87b-4b63-f68e-08dd47758c1b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 12:47:14.5110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yyolac7x4yp7kDaOpgO6m9NIDytRGX03qmAPlWbHYy1C7o9ZvkevjDh8QOaMd8LVn/Vu+2uTOqZgXhqAYQ3ixA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6390
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 12:47:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17182

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Use the URI class to decode and encode an URL. Remove duplicate code and
unify the behavior.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py | 66 +++++++++------------------------------
 1 file changed, 14 insertions(+), 52 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index ab992b7ea..2a60e94ed 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -353,49 +353,9 @@ def decodeurl(url):
     user, password, parameters).
     """
=20
-    m =3D re.compile('(?P<type>[^:]*)://((?P<user>[^/;]+)@)?(?P<location>[=
^;]+)(;(?P<parm>.*))?').match(url)
-    if not m:
-        raise MalformedUrl(url)
-
-    type =3D m.group('type')
-    location =3D m.group('location')
-    if not location:
-        raise MalformedUrl(url)
-    user =3D m.group('user')
-    parm =3D m.group('parm')
-
-    locidx =3D location.find('/')
-    if locidx !=3D -1 and type.lower() !=3D 'file':
-        host =3D location[:locidx]
-        path =3D location[locidx:]
-    elif type.lower() =3D=3D 'file':
-        host =3D ""
-        path =3D location
-        if user:
-            path =3D user + '@' + path
-            user =3D ""
-    else:
-        host =3D location
-        path =3D "/"
-    if user:
-        m =3D re.compile('(?P<user>[^:]+)(:?(?P<pswd>.*))').match(user)
-        if m:
-            user =3D m.group('user')
-            pswd =3D m.group('pswd')
-    else:
-        user =3D ''
-        pswd =3D ''
-
-    p =3D collections.OrderedDict()
-    if parm:
-        for s in parm.split(';'):
-            if s:
-                if not '=3D' in s:
-                    raise MalformedUrl(url, "The URL: '%s' is invalid: par=
ameter %s does not specify a value (missing '=3D')" % (url, s))
-                s1, s2 =3D s.split('=3D', 1)
-                p[s1] =3D s2
-
-    return type, host, urllib.parse.unquote(path), user, pswd, p
+    uri =3D URI(url)
+    path =3D uri.path if uri.path else "/"
+    return uri.scheme, uri.hostport, path, uri.username, uri.password, uri=
.params
=20
 def encodeurl(decoded):
     """Encodes a URL from tokens (scheme, network location, path,
@@ -406,24 +366,26 @@ def encodeurl(decoded):
=20
     if not type:
         raise MissingParameterError('type', "encoded from the data %s" % s=
tr(decoded))
-    url =3D ['%s://' % type]
+    uri =3D URI()
+    uri.scheme =3D type
     if user and type !=3D "file":
-        url.append("%s" % user)
+        uri.username =3D user
         if pswd:
-            url.append(":%s" % pswd)
-        url.append("@")
+            uri.password =3D pswd
     if host and type !=3D "file":
-        url.append("%s" % host)
+        uri.hostname =3D host
     if path:
         # Standardise path to ensure comparisons work
         while '//' in path:
             path =3D path.replace("//", "/")
-        url.append("%s" % urllib.parse.quote(path))
+        uri.path =3D path
+        if type =3D=3D "file":
+            # Use old not IETF compliant style
+            uri.relative =3D False
     if p:
-        for parm in p:
-            url.append(";%s=3D%s" % (parm, p[parm]))
+        uri.params =3D p
=20
-    return "".join(url)
+    return str(uri)
=20
 def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=
=3DNone):
     if not ud.url or not uri_find or not uri_replace:
--=20
2.39.5


