Return-Path: <jamin_lin@aspeedtech.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A76ACD343F
	for <webhook@archiver.kernel.org>; Fri, 15 May 2026 08:03:36 +0000 (UTC)
Received: from TYPPR03CU001.outbound.protection.outlook.com (TYPPR03CU001.outbound.protection.outlook.com [52.101.126.85])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30312.1778832213358424434
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 May 2026 01:03:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@aspeedtech.com header.s=selector1 header.b=ePafGOzN;
 spf=pass (domain: aspeedtech.com, ip: 52.101.126.85, mailfrom: jamin_lin@aspeedtech.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iu1e9FmRXhjtROi2lKs+mZDvJVptzsaRQQo/z6hZyZ34QplPKyheGd1UBxcSQeZT/Jt7qVl6tZfrxxcD2ELFPVzE3kHmIGnKQp0djZVAW0nf3Rax3DifooInjVsHMaVxxIpXWDzipHXZMfIq7/ldCs3wzk7Yx4mvMp722LxCtT/pxY+NB+BZx0uOOWbiyv3H+Vs9txkgzV23Z3I2fVywx1t2Mw42yxwvRLGgpeuo5qcXsUf9TOjfwFVRYNGKIJwJ4qd196AUwFuQqeR1c6d2Co6aMPL9bmQS5XRmew1mtrXowF3ADWTFycrTi64ENf9u3D4ccNHmrHZLrg+c9fKW6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkuEJ5FiyZVhjfoBFPVEMMu3BrB5q2LRLo8SqZwhxXs=;
 b=BcM2Wx1bE6LpObcq9g7s5K/7eJJ4TA4+eLdHBCaaamyhgRuJ/bJXchPV40q4+z7wJID9IzEqRG49EFyADlVEl9QXI8+qWIZTmTbxmlo9YmdayA8iC6wBnMpzfK1fDOFiE7vIHhbbGuSzz5wg1C4loBuBxBNyjfyXeGngVwqLZ5++OwSDVfY5GnHTSEnspHWnw0rMRzU0TuvQR5JKknYimGxSAoI5N77t1bHAMxYB5UC1c1ZEkYlLwlycvGbnsoHUxZSARWPYJbFXVbixVBjDwHWFMsYY7xYjNAUzvA/MnU7ue8eZzO0mITjtHj5DPxtMEamlQ7qpuqa+HJnj1HsD+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkuEJ5FiyZVhjfoBFPVEMMu3BrB5q2LRLo8SqZwhxXs=;
 b=ePafGOzN4pSGmbv+rJ/aTMjAuAdHgKkD0ErGbdZC4v/FnlfjaLs0p2j1stITLswctcnNHn60MtDL1l+P21EU9PYmtZ4J7Moat0vJxlThXpktsDKhgVZUJmJ3QCSy1Sh57fgLlrhVipB6oODf00okoFhhzgCuXt66X7ViNnI/DCBVHN5O0pUH8eqOQzsvN4c5sQGBHWcwvQPfJliWeleyA+AZXsPz7hkhVRZUfxywcaFTnshnmMqepoXxweKiVhQT1etzD0sr9vgLoZGvBZkNygi+AjgOwr2Bp3Q9nDWYzHjp8IEvyShpViE666ylcq3s6Y46tOAZVmrzx+YOmE2Oqg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB7286.apcprd06.prod.outlook.com (2603:1096:820:142::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 08:03:28 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 08:03:28 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
CC: "docs@lists.yoctoproject.org" <docs@lists.yoctoproject.org>, Troy Lee
	<troy_lee@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>
Subject: [PATCH v1] fetch2/git: Fix trailing slash in clone command causing
 double slash in alternates
Thread-Topic: [PATCH v1] fetch2/git: Fix trailing slash in clone command
 causing double slash in alternates
Thread-Index: AQHc5EFQb1a+hPU7RE2Z5etFl3Mp6Q==
Date: Fri, 15 May 2026 08:03:28 +0000
Message-ID: <20260515080327.1285043-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB7286:EE_
x-ms-office365-filtering-correlation-id: a0b12c84-62af-49f2-c00a-08deb25872b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info: 
 2rKgurOEXeM4lyH9g3ioDNDMK4W8UxLf3hJepe0X2CIod78JcsVTQeOTiqczE13s4w5VBYTJyvtvNvOx6jQp02svk5a+T5BUFx+dqM3frHcBa1R4IeGRLhYw9JWjbNVsoCsgylW5MiTs6EEAnD1Ka7SaflxiC3NqOoaJ/jrMLe5Z7yQQCdVDpFgDtpSInHPK02hYWbBNnZFeDobg+lhNNfI8aQqJdjf1+dDcGKI6wgyorlANi6tPVnyinT4emYt+f45KHqRg43vwIo8+qP5zl8F8o9raDWQydB44bz9wt/Kz1qmWsziAiiua+6hIhMoCOKpmbdUKXh8vqwfBifyubSjkWHixDsHpODtVLAGFfV6f7MB9bFVwWing8xO0gWzRp/zzZ2HpzyFKCyEJpqtFFtp3ZFndYFUWK7IP9clf3eh0az5Nypi92jox8Y2EAt6a/Kgz20cr05mHG33mYeR9q+Y85maI6VTLd8Rr13/jEuIbmXj41qy2FunGhx1YSQnM8iwTc1PZi5fPmJtFzYbSvj1WW8yIJ+LsK8sFY50TMZ9UVr9ufElTpDN7/Gj/fChGVfOb216WBSMlrGux5sYc4Y/WT1eIOfBahQt4FUJR9onAxoFHuyIdxX3eaHx9ack+YtJaTLgmHdhMyrWttjjSLe694/h9C09/zIECcteeWD+hIVRTBped06sIfPMreSLylZM9wmtYDSFTYlxj1UjS6NUx4gA1+T4XTznCAmwOn/a/SY/t2m65U3tooVYMgvr0
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYPPR06MB8206.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?R/767o17cbgHD5ir3hKHQIW7yEipFl2Yqtap8AEqn5etSzdOFReGmSN0pgsJ?=
 =?us-ascii?Q?OlUzihvhAlKBBv/U8LUzGdripG3j2LZkg/RcObf0/1lnq40Aa/vRk1gG3Gdn?=
 =?us-ascii?Q?9FNKYsCxCpp6FAIlguR4bb1Oo8nBUAVHLXqcqe5Q19M0c9Kk95CSexKLiquE?=
 =?us-ascii?Q?Z6s1+adWoGCFkBNrnuaLYx0TbqSfDpGEw3jLV3Mq5Dtka5fyyfASmzOVQo+H?=
 =?us-ascii?Q?c7T2aQjBvGb7FQs10fBKQI8diDGO3fBhYYQpmuj4YyVbJlJFvuHhfnn9DN+M?=
 =?us-ascii?Q?By4gsnAU54cNnwASMqQ7WEPZYUX9b+9cdUYCYMmEzSqDVkgvsVYKb8OiAjGv?=
 =?us-ascii?Q?5HcBhgZVE+d4itFygo6FGj9HWml2Ga7akzEqRjI2BFFNREtjyQNxE94rOmFS?=
 =?us-ascii?Q?OsS4zIuJZHlSSHwwdlVREnKrF8L7UP+b6xMnwHGysnb6YrL2tJ1bz6iIkqpm?=
 =?us-ascii?Q?ExUvnyYxwooJTh8NB3u+oaMgu1plFNBh4TWSHSIINy8y21g9HfvpG/Xd7UQM?=
 =?us-ascii?Q?lkZjLDdlfOZHlHmDhoLjFomjoW8CYd67onWuP3QtesA5ELepa+WouU4McZw6?=
 =?us-ascii?Q?+fAcflXneVlYqPVx1KC7o9WqdaWL7RLZiks5ZXrfB3g4A5ZqwdFvfypNreVd?=
 =?us-ascii?Q?XaesZNWO/L62QsijZFxn2RAkdOb+R+N1QVW5J5xuXUlyjAEIqM30jhk0A8ed?=
 =?us-ascii?Q?j/HKLZkKEbYen9jXvLfna0glEHCqT4NlAhQx5HkOAlwPzblAgZOX9TAhf93v?=
 =?us-ascii?Q?5u/5fTIIsyEDq22FhOjzIyi3ASe0jcBTI36XfTZK1B47LyuMhLJ5ozlDlPbe?=
 =?us-ascii?Q?E+79yA09pTaZahWjec0liwtZ1gs61tGjAaOkl+woQgjNqzP1KyUIXtvbAufC?=
 =?us-ascii?Q?RWRwWz9DOAgywjDuDScGI1167FVuLvFQ7oEmB/ZR6jMTbxVGVdu8nelmIf2q?=
 =?us-ascii?Q?gRes8JjVzadTWxmoT1D5IYGctdHBgWy/qux6j3myjhT50Jl5vQvX7/QGn3C5?=
 =?us-ascii?Q?NxJsbksLZHKN03xXyr+4YEAtWjb6NLszcjUV2oy8AChGhJ5rorgZFxWdl1S9?=
 =?us-ascii?Q?hu2SL+x9Fy61T+YdnVk9u/NH0LP2cISOf3hyeU6kX77x/jE9xyGDqQahLcg+?=
 =?us-ascii?Q?+vY4vyP8t+Z2FWY8gaNXNyWeEzHH9xvSZFNM8LFAle+3XVHE35v6rgzP3Cr6?=
 =?us-ascii?Q?DsaUZ8tyqJCf+NQImgkXasMMyIZe7ghCKW+AIjrHk9yR+wLghZYnfz6OtPn8?=
 =?us-ascii?Q?2EKpIp5lpfXZi6E/5o/aChm6fJG5F15SVneonjHZsfElNQWzbCgv+qiPpijF?=
 =?us-ascii?Q?sOOqGKa10Z31JjH5DXWlWEV5XhSfg6Z5GXhgVGQkdOBsvcF68cPXsiIPNosp?=
 =?us-ascii?Q?3hLYZ7v5CxL6GMwRBpfmGGaCuBXOzJure+clxEn81vD2x6ILp8AC3bpOFt1s?=
 =?us-ascii?Q?qQeR+EobjVi2psgLx53PH5Zj1RZjuVD9Lr2iWtBtlSv0Y3CxeHdoRdlDwu5e?=
 =?us-ascii?Q?n+TPWjxZe0u7ybzz2/CJXKzLZoFlBiI2zK0M6Jd7s+Vh27sWiTX+J7gO8IE7?=
 =?us-ascii?Q?OwM6V+sQz7W9b2/Pgm6hiijStlCdRlhncOOeTMlM0zFBuOrrGVE7gQWx744E?=
 =?us-ascii?Q?PWfOgDciEjw1/ZKbn3r8iYUDVt0Ca63VXbVMwm57mn+F0hV97wN6u/MdKjZp?=
 =?us-ascii?Q?MRtCmlUPvoIAGMTd96F5XRFzjvG6IadnO6hjUGzntc1S//yfZExX9x6VJmPS?=
 =?us-ascii?Q?7ErwLRqQyg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b12c84-62af-49f2-c00a-08deb25872b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 08:03:28.4007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cOO/Wt7bUru2t/1v8BqYgncUX/6lVEr0dknCq/Oi86cNt4S1m4bTiJO7SHWcii8O7n7Rcj+n/mkhgTudHv12hGyvq7eoAfg+lFDx+hc30nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7286
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 May 2026 08:03:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19526

The unpack() method constructs the git clone command with a trailing=0A=
slash appended to ud.clonedir:=0A=
=0A=
  git clone -s <clonedir>/ <destdir>=0A=
=0A=
When git processes 'clone -s', it writes the source object path into=0A=
<destdir>/.git/objects/info/alternates by appending '/objects' to the=0A=
source path. The extra trailing slash produces a double slash:=0A=
=0A=
  <clonedir>//objects=0A=
=0A=
Newer versions of git refuse to normalize this path and report:=0A=
=0A=
 error: unable to normalize alternate object path: <path>//objects=0A=
  fatal: bad object HEAD=0A=
=0A=
Remove the spurious trailing slash so the alternates file contains a=0A=
valid, normalizable path.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 lib/bb/fetch2/git.py | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py=0A=
index 01bebb764..b2b39549d 100644=0A=
--- a/lib/bb/fetch2/git.py=0A=
+++ b/lib/bb/fetch2/git.py=0A=
@@ -697,7 +697,7 @@ class Git(FetchMethod):=0A=
             if update and os.path.exists(destdir):=0A=
                 update_mode =3D True=0A=
             else:=0A=
-                runfetchcmd("%s clone %s %s/ %s" % (ud.basecmd, ud.clonefl=
ags, ud.clonedir, destdir), d)=0A=
+                runfetchcmd("%s clone %s %s %s" % (ud.basecmd, ud.clonefla=
gs, ud.clonedir, destdir), d)=0A=
             source_found =3D True=0A=
         else:=0A=
             source_error.append("clone directory not available or not up t=
o date: " + ud.clonedir)=0A=
-- =0A=
2.43.0=0A=

