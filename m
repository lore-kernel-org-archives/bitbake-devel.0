Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.75])
 by mx.groups.io with SMTP id smtpd.web08.29066.1604312714053585638
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Nov 2020 02:25:14 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@technokrat.ch header.s=selector2 header.b=bpCIjI9x;
 spf=pass (domain: technokrat.ch, ip: 40.107.7.75, mailfrom: ds@technokrat.ch)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFRxPyazsvhAazOXo446Q00Q5WLsjvLjzv6CXZoaj0gLTZf5N30FxLMfBPI69NzBr8U3R5ycFdI1O+bTU+vqGba2PtfOCp6ijvS1S3bAH282h2gMisTpoOUIHFOxAijka1hw5P+9ka5KtXEJrWhTZ0Ff76mjQHKjeVMY4KdRc2W71kVB9k+yfJ1Xb13EOQdBY9yHG/dFTmk9q3dEEue1dJjh6mrXCKfLJ+2Ne+j3/wJFkfvvd29Kyj+mBvXYSJv3slKdiy/UJGBPMQT8um34Beud3aQ7Lk0bu4pXE3+6D2pzde+wiVgTOqbgY/yOwDqGPtu0h0ONt8L5qf0c0/mMBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GRXiWef0bAV6ZbgHebBHuTOr3ajqR1Jf1iMb45jEmI=;
 b=ksN9ZL6nJaJ2RuJTLrHwkJihAJWyRl6fUmR9wSslEfmnagfAmCM4FFB+MRhnlc7mKoHP/ocP04o91q7BtmWxUhpsZmGDaWhEDweu0bte11hrd9HhJgmgNUM2rERSpZY8ceKjSaPOXlIfZmZ/WbJ87VvoTxwKu1QZ4R6ONM6HsNlKm/rgUutobSHH35akmN7fBJTUMTfWFyAtGSlFMJj9L3fomqm/9lyHmqaHw0+88z9iKfBvThI53QpQTXxfynbwvE4Yuy1PMHmHg111423Rq1+UwfwdDXriP2YCvLDPza4cqd/pVCtsH39YPD6r54fZ2K9H4sE/RgqwZDVmoP8uWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=technokrat.ch; dmarc=pass action=none
 header.from=technokrat.ch; dkim=pass header.d=technokrat.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=technokrat.ch;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GRXiWef0bAV6ZbgHebBHuTOr3ajqR1Jf1iMb45jEmI=;
 b=bpCIjI9xGeCqd+1rwuZns7ocFYTfDF1Zi+UP7L33OAEfEQiAQgpCAXjyFRpj1nkGZIv4nJZkd14OjrFw9/0lzocsVYR0LCI1kOPwlkJ2yVHuOTmyMZuzsmULKmW0BUvnyf9XYx9QPZK0CmmuUZ3BGhnBxYn1yG0DHerCPwJ+lpE=
Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=technokrat.ch;
Received: from VI1PR05MB6941.eurprd05.prod.outlook.com (2603:10a6:800:18b::24)
 by VI1PR0501MB2479.eurprd05.prod.outlook.com (2603:10a6:800:6b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Mon, 2 Nov
 2020 10:25:09 +0000
Received: from VI1PR05MB6941.eurprd05.prod.outlook.com
 ([fe80::394c:c4fb:7512:6240]) by VI1PR05MB6941.eurprd05.prod.outlook.com
 ([fe80::394c:c4fb:7512:6240%5]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 10:25:09 +0000
From: ds@technokrat.ch
To: bitbake-devel@lists.openembedded.org
CC: Dominik Schmidt <ds@technokrat.ch>
Subject: [PATCH] Append the password to the username on git URI reassembling.
Date: Mon,  2 Nov 2020 11:24:52 +0100
Message-ID: <20201102102452.777-1-ds@technokrat.ch>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [212.51.148.26]
X-ClientProxiedBy: ZR0P278CA0103.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::18) To VI1PR05MB6941.eurprd05.prod.outlook.com
 (2603:10a6:800:18b::24)
Return-Path: ds@technokrat.ch
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from TKRT-DS-DESKTOP.tkrt (212.51.148.26) by ZR0P278CA0103.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:23::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Mon, 2 Nov 2020 10:25:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b186e516-4115-405c-f28c-08d87f199340
X-MS-TrafficTypeDiagnostic: VI1PR0501MB2479:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<VI1PR0501MB24793DF61F625CAFD8972EDCDF100@VI1PR0501MB2479.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VViXUBXhRYJMp4oVJUL8HfSqSrIyZhJvakQAuu9Ri9pvJjS3dKIxsJxp3QjyT8NfbJePf7oyOQPPcLiSgVCM6QU9zdh1SUC1ZfQX0RBptkrrPxreON6r0sXcs6csuQFsABVcleFrfqAUwlAfZqxsMQa0iStrtU27UEbM9C+lhjhH4RXbLFlkKN3+q0tJW8V+Z3L7hQ5fyYc7qT/F+GsvUcYZqNZd974T48kAW5B2GMhPsVx6/0vWpFHHU8qJDwop8Sz3z578M9zp0pg+ab7ExW5TP3Wtk+EGsPzGqSjMVAeOOB93CPTIHr5IJFxbr4uc1LJTxgB4JTjF8+XWnidUig==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB6941.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(136003)(376002)(346002)(396003)(366004)(186003)(6506007)(36756003)(956004)(4744005)(107886003)(478600001)(86362001)(5660300002)(2906002)(66476007)(66556008)(316002)(26005)(66946007)(4326008)(8936002)(1076003)(16526019)(2616005)(8676002)(6512007)(6916009)(8886007)(52116002)(6666004)(83380400001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	3jJFDMQQJzDgVwMxbjLgT+/CGQfk3y3t84Bsl8d98HdqZ0bsUk4sjC4fqLZIvyxyED1DKwAFJtwYuE47ZrE/KFK2Ip3+sgrdUHxPLNg5geH4eodD8EHmjcpmTqHRcRBkMHMfRr7HDGfEyiUmolNBeNvC3ikqjecBgHWQZVTHcjx6yzjzLjPdHw7qBZC2xyZd0jxYPtV3VVsNR4U7hf1h85KmFnqps4i9DVAeTZv8xwnzoj2ctDwCFRj2y0/w3nx61Ukuci4xOqjTKA96M9wQB2CP4swhnBOorlJ6nGQYi8pOKBUoMbLLibyagOJFDjv5T232XMR9hkwM4kHt69zXBWz77FRFRUzpD7r2Ooevz3HXLxw4/S9aGamDIJMFRSEyL2E2s5Hx64CeB5Zo6JW3AjfOf6aLjH4r4wU5meMG9w8sb6FDTpRmbsTB4+cN7bNzqB2+wHR2thNwBoFDJHBUZvQCjX3z3n1ngSkTP+Tx3VcKOBkQqLuAK2S9OvypYMSpxIYgmYvui/Z4OH+0+KgAaa4NIkwSP3Cx4hVabNSDaLq40RpHgv2IYavafi+hLCav2XPSiRhXkXon732WxvGCol3o6nlAn6pBtd9aYjlRBrCZjdVfPyqnfF7+vid1r6gN8WucA/m+cUVbTgApTIMoaA==
X-OriginatorOrg: technokrat.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: b186e516-4115-405c-f28c-08d87f199340
X-MS-Exchange-CrossTenant-AuthSource: VI1PR05MB6941.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 10:25:09.6582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 64080179-9a04-4263-af11-c40cf91ee504
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HdCpMqG0NEHurD6lwSfcHrrbg69l418dmj3iNIViDJ8FzP/IgwPpG1uzrDlPjHuxZKol5PJqll1pvDzBqBRgfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2479
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

This allows the users to specify SRC_URIs of the form

	git://user:password@host.tld/path/to/repo.git

which allows pulling in private repositories.
---
 lib/bb/fetch2/git.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index b97967b4..090fa173 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -596,7 +596,10 @@ class Git(FetchMethod):
         Return the repository URL
         """
         if ud.user:
-            username =3D ud.user + '@'
+            username =3D ud.user
+            if ud.pswd:
+                username +=3D ":" + ud.pswd
+            username +=3D "@"
         else:
             username =3D ""
         return "%s://%s%s%s" % (ud.proto, username, ud.host, ud.path)
--=20
2.25.1

