Return-Path: <mvader@victronenergy.com>
X-Greylist: delayed 20191 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 12 Feb 2018 04:07:55 UTC
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0110.outbound.protection.outlook.com [104.47.2.110])
	by mail.openembedded.org (Postfix) with ESMTP id 4811D77E76
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Feb 2018 04:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=VICTRONENERGY.onmicrosoft.com; s=selector1-victronenergy-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
	bh=r5azxzJ/x6ysXRWtS5l3aSRyqlxpQDyIIhnId7dDLr0=;
	b=X4TbhlIFiQt5Pz1HpPykP6CFU201Bu2O6QKe2zJDa4qLVq0tx24rx1IlwyhLN5oXr2DuaY3nb02o+m/PRbYrRC9TOQdpIg77RTgq4bdv2cNHce14G06wX6UDJMx+kyTAOovsORTx26F+RlpSDRwk+7y/zgPaY9v8qzgXupj0g4w=
Received: from AM3PR07CA0054.eurprd07.prod.outlook.com (2603:10a6:207:4::12)
	by VI1PR0702MB3662.eurprd07.prod.outlook.com (2603:10a6:803:3::32) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.506.7;
	Sun, 11 Feb 2018 22:31:24 +0000
Received: from VE1EUR01FT064.eop-EUR01.prod.protection.outlook.com
	(2a01:111:f400:7e01::203) by AM3PR07CA0054.outlook.office365.com
	(2603:10a6:207:4::12) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.506.7 via
	Frontend Transport; Sun, 11 Feb 2018 22:31:23 +0000
Authentication-Results: spf=pass (sender IP is 89.20.169.246)
	smtp.mailfrom=victronenergy.com; lists.openembedded.org;
	dkim=none (message
	not signed) header.d=none;lists.openembedded.org; dmarc=bestguesspass
	action=none header.from=victronenergy.com;
Received-SPF: Pass (protection.outlook.com: domain of victronenergy.com
	designates 89.20.169.246 as permitted sender)
	receiver=protection.outlook.com; client-ip=89.20.169.246;
	helo=mail.victronenergy.com;
Received: from mail.victronenergy.com (89.20.169.246) by
	VE1EUR01FT064.mail.protection.outlook.com (10.152.3.34) with Microsoft
	SMTP
	Server id 15.20.485.12 via Frontend Transport; Sun, 11 Feb 2018 22:31:23
	+0000
Received: from localhost.localdomain ([10.220.13.30]) by
	mail.victronenergy.com with Microsoft SMTPSVC(8.5.9600.16384); 
	Sun, 11 Feb 2018 23:31:24 +0100
From: mpvader <mvader@victronenergy.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 11 Feb 2018 23:31:15 +0100
Message-ID: <1518388275-4589-1-git-send-email-mvader@victronenergy.com>
X-Mailer: git-send-email 2.7.4
X-OriginalArrivalTime: 11 Feb 2018 22:31:24.0843 (UTC)
	FILETIME=[0CBC67B0:01D3A388]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:89.20.169.246; IPV:CAL; CTRY:NL; EFV:NLI;
	SFV:NSPM;
	SFS:(10019020)(376002)(39830400003)(396003)(39380400002)(346002)(2980300002)(438002)(199004)(189003)(51416003)(2351001)(48376002)(6306002)(47776003)(966005)(86152003)(5660300001)(336011)(4326008)(305945005)(106466001)(186003)(587094005)(53386004)(107886003)(356003)(50226002)(49486002)(16586007)(316002)(6916009)(86362001)(104016004)(106002)(6666003)(50466002)(81166006)(478600001)(2906002)(1857600001)(8676002)(77096007)(26826003)(81156014)(36756003)(26005)(8936002)(69596002)(43062003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR0702MB3662;
	H:mail.victronenergy.com; FPR:; SPF:Pass;
	PTR:89.20.169.246.static.ef-service.nl; A:1; MX:1; LANG:en; 
X-Microsoft-Exchange-Diagnostics: 1; VE1EUR01FT064;
	1:zgdeKS4C1+jHWa4qQn9hhXK+Gv83NYW9OmJB82PfG7CgeMaE0RbmyANBqkq3eRGmrvHKMyfHizg3E/Ilqt953wSXVMVaHiXDDQgzrqrnEOMopYsK0XZLoxrMKSEYc/6n
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3b91f6f-1203-4a3b-05a9-08d5719f2e71
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060);
	SRVR:VI1PR0702MB3662; 
X-Microsoft-Exchange-Diagnostics: 1; VI1PR0702MB3662;
	3:jQZP3Bn2ze2TcYvJ+wY60wij/1TANCKAT2LP6JSi8EK7SXujLGg2d+htfVPi5FqK3QOL7/dN53QoVTwh6Goa6Nbt2gljWrpL8ba2mD0UgTliFDTnWHjRFNhtNBey5AkyiEmGr8JnfbQFWgFC89E4mHtXs2mo/ujTGqoHNmQvcFr530WZ5DbXCRmXipCjOWDuLybhD8+2K1gPo+1p5glbj3bKl98imIXmCiRWp9XXDtJr+QTbhYFGu3p/t+/y+uC6dolLcIFibgPSh+plw5vg/jb5gX3FbiwXkuAzdKqYK3EQe0l/1VRKR2tAL7GOw67V7R2IRCE8cFuxVounHRXqqFgnNEjCllZ50SDBxcNVti0=;
	25:AJCTtXOFe9+8mljkylWTQIqVlBbmO4nYLSp9rJRdL6sMjAbpFCuObKn2aEtOZX+SAlzBInZXPMoEvL6Th/YGB9IOQNa4R7UvHO6jdELcbz7crpSXs40wIq40AAyAKhN1wQZbAXkpWtsqit+f14ZEkWuFmw7z/krGJpLrdJpODw75zumJTJdp+vU4di9USnxvTUTSVoZzkxPxT/hsuIkid5iIc9TOX+tqvOk5AVj74mxpwWBudTAX4KmQl3FJ/ihCs0D+NxzrjUvXUXZRHVUTFysnq5aN8MdCBVdgA5iaJUWLpykPG4YC4mXDAb1gKhm4hdr3ZtTfcWil3JAHbSYwZQ==
X-MS-TrafficTypeDiagnostic: VI1PR0702MB3662:
X-Microsoft-Exchange-Diagnostics: 1; VI1PR0702MB3662;
	31:3JL8armOiDGB0vUJXlQDAZLoM7+i3gWbO2Ki1A9hUnnG2hhQIKrkqs0MLx5PJ9r6pg5KZ5t1Q1z8mGHv4gl9IGs5rMh/HbHN3V7ETkqiarrsWe9ZZSh2lDU7ml6ALisSC/rogCDVoa3k+I4aVFMsX17UeF6WyP5vYYIBMzuKTlKDmAkt8FRzSiILsXIjP0TXPOBRT6U+GB4WxvRRRswPg912xCHGDu8tlrQLdw/srhs=;
	20:6F7+IpY0KWdXB8TekA8LFy9miTLHKT3vw9vHaFwQomJLlFRpFgjta2zK/ZLeVUnWSTG17WgSjCKyZtwIrA1C0h7P/7gcEAvoGiPZHSBF7NzFZXRwnFE19dT+t2Z7Lqd60acCC9QFfu0pY9iv3c4tKXGhrpJyrV0E92gIHc+bk3jsjqJJ3hXvD8O+PkdVKBDb0l2aIsyIUPRgjTUVu+h18zyFolvEp26gpRyOxBMeYQdHnax/ZLWbII0HSInu733dCo8Ff1utho9P7eZ6T0PDFVHgogGx5aoPNCVEAB/l3neblQgdorCKUprgtF7dOW1zisp8VAkOT2V+7Yp5qv0hbBwuDrSCcjL45uxSuZYZNhs=;
	4:FzW664ER6GncyRBsXTBWW40ll7WjZ9Uy8PnCLBK+2+Xl/bO2gzv7UFG07ozp0dKzujhs32HQgVFBYMzHPH4TxDoSVdy8iCVkkXJCl+17l+rRAwG5NPAoaxke4GR4BQevzn4Glq63CqWY+jmEGN9Cew7bpIiCkHcQDghM5XrMig2FJVJxVGN1lslbHcP9vPYbI+AW3yt1S1GzFhDk2C399kFGgLe/1buqS8NMePIlzGVr4Oh0zwQ0PZSMYNbB49TdnxsnsG+ZvmKhzSfm27dhXIANobXSx/sNTQpBT2GhVh/apnkWXSra2MVel2Dp2ksj
X-Microsoft-Antispam-PRVS: <VI1PR0702MB3662747F2C843475EDADF014C5F00@VI1PR0702MB3662.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3231101)(2400082)(944501161)(3002001)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
	SRVR:VI1PR0702MB3662; BCL:0; PCL:0; RULEID:;
	SRVR:VI1PR0702MB3662; 
X-Forefront-PRVS: 058043A388
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; VI1PR0702MB3662;
	23:pUvvNYsx+0ysHlVf1BPPcFqtuhPAVLFY7+mqw54?=
	=?us-ascii?Q?9XSCDyZZc/LOkHwFBKW6cb1/df6UIdT4turEDJIe10vqBjfsDkvV09o6L8hG?=
	=?us-ascii?Q?T93p+yoNpWlDZQViwv2tQOnkcjOUBaLGA9ZRqVCRBoeXTH+GvEJWD8aO5JbW?=
	=?us-ascii?Q?qN7dIS266iXw7arAkDnsaSFUcbo+tu4KJ7mi2XL3WWLwJ0COhIvNN0MUpHPg?=
	=?us-ascii?Q?EHeMXBSzbGzl5QCl98djNhxw8rcPIXyAeJe9r2wU0TpwlmDhEt+9vGL6qXhT?=
	=?us-ascii?Q?yc2pA/q8t+hO4SFYnh0eoIm4WGi8N1lwJVlXj2hZ2KlwnEcTYnMJ2ENgM93i?=
	=?us-ascii?Q?VkJme9OXARoHuqvpsJ/nqVUGS4yPOm9GWbM33SscyDLy8AyrY2a4fQCY5zPC?=
	=?us-ascii?Q?9daQNwWF/oyLt3I8yDTmlW4PIEYZpDm9xpHSOv3hBTcgkcDa56aoNnVTNogS?=
	=?us-ascii?Q?riBTpZWy9Gb1PTj495uZKBGxumxipSCIUyYkf8Zk3pGRoc8zaRgiH6Tty8j+?=
	=?us-ascii?Q?H/LOHhJ7rZq+UGORHfVQjQw9XKO9B8fZ/O24zsHt0s1zEcuPxkevo5TscoWl?=
	=?us-ascii?Q?Wr5iuE6bbP+lZRnhhfQ+SmnXbkDh39CTMCyMK+lfq80gVU6kzDG1RHC8a8l5?=
	=?us-ascii?Q?aCZpTKo86KIPdZb+KwICwZK/ujZr5CqtgObL0QzO2WymXKpd17YVEO4HcLVh?=
	=?us-ascii?Q?Knd5tb+CxfHO2lnnmRYrwgfbjaGexn2bkKKbwE06ztCmFanl+DSVpwIEKzyR?=
	=?us-ascii?Q?KG0O7/6q07jgAkwbLTvA7X/5uSvO2Ktde3g7KB+LeHeBa2wz50mx5Y8Q1bW2?=
	=?us-ascii?Q?2JDnbGoX3td+lfFp7w2T54mOVG9HYcE5zzde8hpXIpVrkAlZWSj0T4U5TwYD?=
	=?us-ascii?Q?z3v20L8Z1FEwOJEpQX5A9w4PfL71soj1yXOZLLH+Wgkk6iT6p0LjJXivuHET?=
	=?us-ascii?Q?jO21xOJBhq3i0JLaKdfKKUAmrO+/9bMrMpwLll9Z++uq+ntPbjbdL+0E3GcB?=
	=?us-ascii?Q?jplSUac5PHQZM0xQFIHDwVsO9FZCqKDwX5Tz3BxDrPiXcGwx6D+OamNE9fQj?=
	=?us-ascii?Q?cgKC9701AZVbujDJZdR8RuLSJP7w6w3LkDusln3YrqTr8ulx8wf2t15xQSx5?=
	=?us-ascii?Q?h3lxP2DiQttI=3D?=
X-Microsoft-Exchange-Diagnostics: 1; VI1PR0702MB3662;
	6:NPfrlKfQ8ccjLnStrmi6Fe20aSQNbpq+gXtooxoTLP3UD+sJHY7ynYaNqCwmwl0L6MmuA1qKvJjkF+qpLSZQY/vIjrDDM9hw3/2VqdU9meRqRb37Dpy0Ph6yITUClHgfczWcj6wI2z52fC3y4OwWQ1SZ/vd/qS58N6/4Xzl7aRRREMts00SE3qIISnpCFpmxx0JTxVuUmNDTLElm/Z4vx5CSIVpsD7n1uD3ahSwGtYibEl74dc/9w4ENuctbUTQcot5t3WTzFgEP+5Qr7nfJJcTCgOgccV/ZzCRVS5bWQAY40zNJtgJBMvYCXbvHly1Amf/PQutHLQwYK+7qLyhBifu5c/xWElushvEPXEy+2qE=;
	5:3C1n4hY/AnEnW3uJCSqz3OSB2or3J+sSpt8L15VMqZztXrb1XQeRsBO5l73oyUxL7bSVsRR4B3GTj8KT7X09MH7LMv3m5ZVNQwGMlCmyV1sO/2eV1WVJblD8U+QlcFVbej4/cH1WMCysXeyN23xVF/QW8I4GRDLvuabuOF/GlmU=;
	24:ccA8M2lEw94W2IGoPUh+AG6DmTcEd/0g25VpOSLc5+vKSHZVh42evOyVPeJ0GHeCxmwh4h32oDikHOPZjw6Pm5DZy+qbPosnTpM0TP/wbIs=;
	7:BBHP/DBo2XNohvByMpdoHnYv+iKfiV5X8vr15PEVSi+GhbufEHXE0S7M0NAITkQum3rn+ScqvkrhivqjgtsgnWyUK9yH5pQs8u0VmJq2BK9w+wUdTgE4735NBbeVNwc2ewKBlgzbyFp0KekxzcNOe5ON/+JNqRTrFNwdLet6itTsiZHAP3AS72lc5/9YqujllT0xRDziuNkMX2+3zV8ks0EINC+uk+CtJT7IJTsFjUYXla1M0TXVUx8acLu/XtPk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: victronenergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2018 22:31:23.4909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b91f6f-1203-4a3b-05a9-08d5719f2e71
X-MS-Exchange-CrossTenant-Id: 60b95f08-3558-4e94-b0f8-d690c498e225
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=60b95f08-3558-4e94-b0f8-d690c498e225;
	Ip=[89.20.169.246]; Helo=[mail.victronenergy.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0702MB3662
Subject: [PATCH] fetch2/npm: fix parsing multiple matching packages
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 12 Feb 2018 04:07:56 -0000
Content-Type: text/plain

Replace the self-implemented parser with loading the complete json and then
taking the last element from it.

This fixes an error fetching the lex-parser package, as a dependency of, for
example, jison. Reproduce the error with this command:

devtool add "npm://registry.npmjs.org;name=jison;version=0.4.18"

_parse_view() didn't properly parse the npm view result [1], resulting in
an Exception in the subsequent json.loads() function:
Exception: ValueError: Extra data: line 57 column 4 - line 296 column 2 (char 5874 - 29698)

[1] npm view lex-parser@'0.1.x' --json --registry http://registry.npmjs.org

Signed-off-by: mpvader <mvader@victronenergy.com>
---
 lib/bb/fetch2/npm.py | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index b5f148c..e257355 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -146,25 +146,6 @@ class Npm(FetchMethod):
 
         self._unpackdep(ud, ud.pkgname, workobj, unpackdir, dldir, d)
 
-    def _parse_view(self, output):
-        '''
-        Parse the output of npm view --json; the last JSON result
-        is assumed to be the one that we're interested in.
-        '''
-        pdata = None
-        outdeps = {}
-        datalines = []
-        bracelevel = 0
-        for line in output.splitlines():
-            if bracelevel:
-                datalines.append(line)
-            elif '{' in line:
-                datalines = []
-                datalines.append(line)
-            bracelevel = bracelevel + line.count('{') - line.count('}')
-        if datalines:
-            pdata = json.loads('\n'.join(datalines))
-        return pdata
 
     def _getdependencies(self, pkg, data, version, d, ud, optional=False, fetchedlist=None):
         if fetchedlist is None:
@@ -175,9 +156,15 @@ class Npm(FetchMethod):
         logger.debug(2, "Calling getdeps on %s" % pkg)
         fetchcmd = "npm view %s --json --registry %s" % (pkgfullname, ud.registry)
         output = runfetchcmd(fetchcmd, d, True)
-        pdata = self._parse_view(output)
-        if not pdata:
+        if not output:
             raise FetchError("The command '%s' returned no output" % fetchcmd)
+        pdata = json.loads(output)
+
+        # npm registry will return multiple dicts in a list when there is more than one matching
+        # version. Take the last one.
+        if isinstance(pdata, list):
+            pdata = pdata[-1]
+
         if optional:
             pkg_os = pdata.get('os', None)
             if pkg_os:
-- 
2.7.4


