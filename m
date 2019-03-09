Return-Path: <chris.laplante@agilent.com>
X-Greylist: delayed 32316 seconds by postgrey-1.34 at layers.openembedded.org;
	Sun, 10 Mar 2019 07:57:04 UTC
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
	(mail-eopbgr730080.outbound.protection.outlook.com [40.107.73.80])
	by mail.openembedded.org (Postfix) with ESMTP id 74E127C6F0
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Mar 2019 07:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=FS0CH/qWtdz41/80HG5mAJqISeN4g06aw8iVH3bxmoI=;
	b=TS03tUPi1xQixyx0avTH1hAENG9LDjA8khvzq1PK4+T1WhiqZbiq9CQqI2m0zssRl1cRmbQBxWjYtbamdJ9xY9skfDqAsT4Ko4UTTphaxd0id6SMa4Ll1Pb9OEQn+LOYKB/y8s6O6TfkqdThQzCBojM5d8MRfC5Rmd0C94WQr/I=
Received: from MWHPR1201CA0002.namprd12.prod.outlook.com
	(2603:10b6:301:4a::12) by DM5PR12MB2503.namprd12.prod.outlook.com
	(2603:10b6:4:b5::18) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1686.17;
	Sat, 9 Mar 2019 18:23:09 +0000
Received: from CO1NAM05FT024.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e50::204) by MWHPR1201CA0002.outlook.office365.com
	(2603:10b6:301:4a::12) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1686.16 via
	Frontend Transport; Sat, 9 Mar 2019 18:23:09 +0000
Authentication-Results: spf=pass (sender IP is 192.25.218.35)
	smtp.mailfrom=agilent.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
	header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
	192.25.218.35 as permitted sender) receiver=protection.outlook.com;
	client-ip=192.25.218.35; helo=COS-US-IRON04.COS.AGILENT.COM;
Received: from COS-US-IRON04.COS.AGILENT.COM (192.25.218.35) by
	CO1NAM05FT024.mail.protection.outlook.com (10.152.96.132) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.20.1686.5 via Frontend Transport; Sat, 9 Mar 2019 18:23:08 +0000
Received: from cnd6270d8d.cos.vpn.agilent.net (HELO localhost.localdomain)
	([10.46.22.111])
	by COS-US-IRON04.COS.AGILENT.COM with ESMTP; 09 Mar 2019 11:23:08 -0700
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sat, 9 Mar 2019 13:22:33 -0500
Message-ID: <1552155753-55375-1-git-send-email-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: =?us-ascii?Q?CIP:192.25.218.35; IPV:CAL; SCL:-1;
	CTRY:US; EFV:NLI; SFV:NSPM; SF?=
	=?us-ascii?Q?S:(10009020)(346002)(39860400002)(136003)(396003)(376002)(29?=
	=?us-ascii?Q?80300002)(29502001)(199004)(189003)(186003)(2351001)(7709600?=
	=?us-ascii?Q?7)(8676002)(246002)(6666004)(5660300002)(336012)(2616005)(63?=
	=?us-ascii?Q?266004)(426003)(6916009)(86362001)(4744005)(14444005)(356004?=
	=?us-ascii?Q?)(316002)(47776003)(106002)(51416003)(106466001)(26005)(4483?=
	=?us-ascii?Q?2011)(126002)(104016004)(486006)(107886003)(8936002)(4786000?=
	=?us-ascii?Q?01)(4326008)(305945005)(50466002)(48376002)(476003)(16586007?=
	=?us-ascii?Q?)(26826003)(50226002)(36756003)(7636002)(2906002)(5001870100?=
	=?us-ascii?Q?001); DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2503;
	H:COS-US-IRON?=
	=?us-ascii?Q?04.COS.AGILENT.COM; FPR:; SPF:Pass; LANG:en;
	PTR:nonbpi.smtp.agi?=
	=?us-ascii?Q?lent.com, relay.britain.smtp.agilent.com,
	ap.scan.smtp.agilent?=
	=?us-ascii?Q?.com, bastion.sgp.smtp.agilent.com,
	relay.ap.smtp.agilent.com, ?=
	=?us-ascii?Q?*.sea.smtp.agilent.com, relay.and.smtp.agilent.com,
	cos.smtp.a?=
	=?us-ascii?Q?gilent.com, am.scan.smtp.agilent.com, am.smtp.agilent.com,
	*.ou?=
	=?us-ascii?Q?tbound.smtp.agilent.com, osi.smtp.agilent.com,
	ap.smtp.agilent?=
	=?us-ascii?Q?.com, scan.am.smtp.agilent.com, and.smtp.agilent.com,
	eu.am.smt?=
	=?us-ascii?Q?p.agilent.com,cos-us-iron04.cos.agilent.com;A:1;MX:1;?=
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43ceffbc-5cbd-4708-ed08-08d6a4bc480b
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);
	SRVR:DM5PR12MB2503; 
X-MS-TrafficTypeDiagnostic: DM5PR12MB2503:
X-Microsoft-Exchange-Diagnostics: 1; DM5PR12MB2503;
	20:giobxOYyGcOhChUZtWHadtOSk4aJ4sLWnMHHiLqxJcrxljnsoGg6NaQDI0MYjOHuEddwhulumGHn4kLRKnetuEnN+0g8S51cQPRvSTuaSXbhBsqzGOTzfqZNl+LWSjRR9kJZXxrfgKZ3hu/bx+oFeyx1VwJd0vrIJq1Sl5vrDJLyq1yqtyrUQ/aNwGiT2yxGkn/msM0ucpj/0JdyV51/BgpokfztY+umGE0tJJcdjQw05bmOQIhZ/hygceRLEy0AXjMGzT0XZCUCdI2VFdVgh9ivDmksRp1GxMgisc/ccolnMxfptznqMTqmO3DnSfvLBYNT1QJr9/4HfuyRx049k8DjlgkF+KtWFDYAyiYtKCc74TfnTUM+HlhM6cD2eBKiRhJe2K4q15zB81nukEfSXmqX/IcKAja3fXoJceaeigdkW6mCgOVyKCsyZRNAPJH8FXLqa3ZQ8PCeA3z2cqPpYHxkGuyeQ45VmxXQ2u9tcHQ+VbEfvG8DdrBQbSl+wLJHK7A9J87lIjo2GecuWPt01oWlPeo5gNnsHl2YhHfl5XOqYZd79Ak8LKnHA49uaawIX0dvJKaJ//gMMOhqZIsAheJJGaF+n1fDr+CUxRuDcdQ=
X-Microsoft-Antispam-PRVS: <DM5PR12MB250309452286C3AD5D22F8318B4E0@DM5PR12MB2503.namprd12.prod.outlook.com>
X-Forefront-PRVS: 0971922F40
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; DM5PR12MB2503;
	23:6V2Xcr5sZV6pjWw+5GjKaYXFuSx/Ueh7x/NGHnWyA?=
	=?us-ascii?Q?w+FkPKSiAQo4OAuein79QaBdMAfaJIDReRNlIxTA+4MQNbuUburhyBXX1fq4?=
	=?us-ascii?Q?iUMMS7wtCSizIB89Cyt6ebTWYzqIa6EhHMW+h5PQT6V5IxeeP9tWA1mu8Rh/?=
	=?us-ascii?Q?K66imXIe4WSpjBHz2B3EgGYV5BciBpvaCajSbO2XqFvIPfc1iFCNVkt7oWzE?=
	=?us-ascii?Q?JAS39eNJ7xeUR9MkQZ71CpUZZzaLXTfa6MHglgZE6M8Wt0B7LFx59aTX1Ltm?=
	=?us-ascii?Q?SIP/r/Y24QSm40Kfx6E9qkURTsxx32jI+OsTJyMeN6es7gYvd7crWPGhGNd1?=
	=?us-ascii?Q?FcdghsqJJV3k9vI+kqTWMGd1TECCaw/jR2WVtt5f4cDuFrrNHKtR/RL2tzqu?=
	=?us-ascii?Q?rAD/usQciw2kyH82EAvrqnK+klkSLhCDAlhGOurbQfv8Ozs9ClDl4/Frigkg?=
	=?us-ascii?Q?a+pYBUXOia/uuvNyCF8nUvm6Unn8TVfMTIhadksHZsH8y5YxX2t3rCbr1+wn?=
	=?us-ascii?Q?1iwsMKrxmaaJGLkyFKHhkY4MF3ty39lOfd9rk82bUV7gY5AsjKb1iPXigTKl?=
	=?us-ascii?Q?/vdXj/OV2NWA6MQ2rce5etsLiDG2kQJj9p4BzP9cXslO7YQtSKedaShw9vbb?=
	=?us-ascii?Q?5gM6ZMWkVGLXyxiO81WyC5zCTz/NWK02cehbk1ARqto8+xUlEWHaiQ1Q+d/x?=
	=?us-ascii?Q?CXGPoUIWSEPFcqHoBRolSD9KvpbMNsm7Bkw5xnDVtgbXK2iAV9dBvJHzv4U+?=
	=?us-ascii?Q?GVgGKuxIIZdTElWnFSHZ5lkzefJIF3cxdDgVhXk/kT2D+bW0jnhzEQt0C3OR?=
	=?us-ascii?Q?A5qq9tRRcIQk7BXddp6jqUQ38fyzn2pK/iwctUTaqNcDXMleuI03ssGqw9DI?=
	=?us-ascii?Q?kMSfWnrnkoGGUp5O5cBgMPiGvynYODOymhT0iTkndsokivN/hvFPBn7IkpGT?=
	=?us-ascii?Q?9dZmFHCmiMcKB2Q4hFOEXGPfEZZPHPqKIqZIWExEjYqiae0d+Je38ioT7xBs?=
	=?us-ascii?Q?ecLCQHCFya/vsP/f2vltxYkE2GnqrIjsgd+qyD1PNHV4UDeVkseGRDXqEUQ+?=
	=?us-ascii?Q?k0kodPVUzMr2p5bf7vAKS0v8DpcOnwEuxYJhKuGamhTYJyDG53SdjXTdLKzI?=
	=?us-ascii?Q?wFmw4v91NE=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 3OyKit78xvGOkUCmaaNZZEqqe1NjsGPy8oTqNMMNpHl84G6tFvjW+0g/MLuLy8v1/719itSjfZIvLouaFaLeQuA0pT1g6I0BrW7s5fckfSB2F+30Jyg2PYRa+OH9kq7gjlaWwZuFqCnu7jITSO7IV8U18Cr7De9ydtK8aLZhRFv23vdEdGc2R9yGjrA9Pe+/3KaKhOA9xbqRVId261Y76udH0Nnp31V9P7SIX0kiAWPEe+pAe61g7kCN9vtUNUtOYE3DbXL09tD5nGB4+s5OaQAdBc0EqyfUm9BUIXjA+yL7PVWtU7nQEI7lCyKPBjd8k48ui1KKXfo4CitoqCoJBGI7h3v3YtNcKkOd6a5M0PeckK2cubHHR0GnvfWyFxMI1FxEhI+hWLvDIEcvxeXMJWHHJLWidc8IVtGw4xMXSgU=
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2019 18:23:08.7480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ceffbc-5cbd-4708-ed08-08d6a4bc480b
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.35]; Helo=[COS-US-IRON04.COS.AGILENT.COM]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2503
Subject: [PATCH] bitbake: ui/knotty: allow rate for indeterminate progress
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
X-List-Received-Date: Sun, 10 Mar 2019 07:57:04 -0000
Content-Type: text/plain

There is no reason not to allow showing a rate for indeterminate task
progress. It can be useful, e.g. when downloading from a server that
doesn't give the total download size.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/ui/knotty.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index fa88e6c..f4ef19d 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -293,8 +293,8 @@ class TerminalFilter(object):
                         if start_time:
                             pbar.start_time = start_time
                     pbar.setmessage('%s:%s' % (tasknum, pbar.msg.split(':', 1)[1]))
+                    pbar.setextra(rate)
                     if progress > -1:
-                        pbar.setextra(rate)
                         content = pbar.update(progress)
                     else:
                         content = pbar.update(1)
-- 
2.7.4


