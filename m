Return-Path: <chris.laplante@agilent.com>
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
	(mail-eopbgr690045.outbound.protection.outlook.com [40.107.69.45])
	by mail.openembedded.org (Postfix) with ESMTP id C9AE17F5AD
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Oct 2019 16:23:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=WNKtolt7gjuSkDf7yKgZWc8aXftsbji3tGDuoJwRr1NQ7lDsGHkegAAEP9SH0QyBhZZrYKIxQQ0ZvnyYa0VlvtYpsoGq1kOC83v0/ReWXPtz1ZfJtjO9Zx8nBqnecVlhFw7rb1z+y+8GUXiuR3QC7TQVcf8F/yWmPWYh01yu+PwFhTr4zYpzxyGHKlzaRrAWz5uhYPvvnrIvp1dWPrPQri9rxn2+zyS3L1INCcPGxAfB6PF+L5IgP9IYNbwLJwD9LB/MqvRq1OnliBvVy/T670ACe+oWT4BQXUo4maIz+VgMvKa+/3kdc6rJ+/pNCWJfrHAuwPwdpuw3gF/LgbkE6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=0Ml5P5tGLXC4EEkAacQjKBcrjKsu9Nr8DtNClQpdqxY=;
	b=KOxtUfBMInWwLkBdEembw1mGTMHaFP8JEor8TebBSgM4AmiQwxA2mt99XDGP9RrRAQGyFwsDFmJT0OUvSLxfbRGydKgt2BGLAo7rSHtNu1w39rhznvEFxxUV5OaJngFEeIvxIi1dLRB8K+Y4olPxp5VuKh6GyXCIHMqHvRKfwmFV8A+3LhYqTZ9a0pBIpxAKURSBnVQEVhhARszCqdDbDXY2asVAEqMeImoeZnFsBh819XFXaAFDgp2Y1Jt8KKoAttBbFrUmiwXDTQC4Lg1eS3ZlLwnVvDf9d5vwf7dJ6x7UhBu71ayahO/WWMUXFKgr1S3O5g4ye/teuP9qZo/wmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=0Ml5P5tGLXC4EEkAacQjKBcrjKsu9Nr8DtNClQpdqxY=;
	b=OEywpUgextppfrWaZNiWFqLOC3ZDyf7n1Zy5+czYp2OytVYA0cuaL0bMiaCbEmW8o5PNho+EQPUsAJ0t/hdw7WX6gbBcwYcDhRtlIu7WebD2gsM7p+w0g59GQ27ATcV1CPFkkl87jzZmZ4c7TIMbacSH0wlpb+zQ9IqaESPTkjw=
Received: from SN1PR12CA0047.namprd12.prod.outlook.com (2603:10b6:802:20::18)
	by BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17)
	with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16;
	Fri, 11 Oct 2019 16:23:22 +0000
Received: from CO1NAM05FT027.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e50::204) by SN1PR12CA0047.outlook.office365.com
	(2603:10b6:802:20::18) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16 via
	Frontend Transport; Fri, 11 Oct 2019 16:23:21 +0000
Authentication-Results: spf=pass (sender IP is 192.25.218.37)
	smtp.mailfrom=agilent.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
	header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
	192.25.218.37 as permitted sender) receiver=protection.outlook.com;
	client-ip=192.25.218.37; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.37) by
	CO1NAM05FT027.mail.protection.outlook.com (10.152.96.137) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2367.5 via Frontend Transport; Fri, 11 Oct 2019 16:23:21 +0000
Received: from localhost.localdomain (130.30.246.172) by
	edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server id
	15.1.1261.35; Fri, 11 Oct 2019 10:22:47 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 11 Oct 2019 12:22:58 -0400
Message-ID: <cover.1570810590.git.chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg1.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.37; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(396003)(376002)(39860400002)(136003)(346002)(29502001)(199004)(189003)(26005)(966005)(44832011)(478600001)(426003)(2616005)(476003)(126002)(14444005)(51416003)(54906003)(316002)(186003)(106002)(486006)(2351001)(16586007)(956004)(336012)(4326008)(50466002)(246002)(5660300002)(48376002)(6916009)(7636002)(305945005)(8676002)(6666004)(356004)(47776003)(50226002)(2906002)(8936002)(70206006)(36756003)(86362001)(6306002)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB4067;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:cos.smtp.agilent.com,wpcosapexchedg1.windmz.agilent.com; A:1;
	MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a7a0a68-b556-471d-7bbd-08d74e67552f
X-MS-TrafficTypeDiagnostic: BY5PR12MB4067:
X-MS-Exchange-PUrlCount: 1
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4067AD909C6296E55C39E72A8B970@BY5PR12MB4067.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-Forefront-PRVS: 0187F3EA14
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rAV0fDS8md3yY/rAxUgVOagvdkmVQ/cz01qi699uVfGP8qPQBils1PIMkh+4PiiBBAJJw+HV/TsfL2Zz5wyRADiXHpmpzOaIgcy1myhhzGfGmzKrfFicQ99KUh5BeiZ79enVtHYcmTpkSzXMQq8alSTiR1FVI/kpJwuZDKk7eKLcxX04ik8EVbMQC5xpHCWWN6+WvxJ1nAv7/Jt6bsIbVE03wv1QJ4CT8kfjLQmGGkqlph5k8GeTp3HR6OzrKOqu8iPY0LlMVD9Q+u9D5tGnRpPXb+L5K0es5P++apgxCdQe7fojN/pSmkwM3U24x2BEoPkmOv2I/RKYfenIIbHnM9T8sE3pDHh1RCSQehIZvYVoMg7m9EXDaiCN26gvTUkcieZgv+pqBAdByxemrCcr0GrOrfL5s3+Ov70lYVIuPRBkbbFjuk5Vv10yVVWgEbPODdy14PWz/UH8swhU98u5cg==
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 16:23:21.2596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7a0a68-b556-471d-7bbd-08d74e67552f
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.37]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067
Subject: [PATCH 0/9] BitBake Vim indentation plugin
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
X-List-Received-Date: Fri, 11 Oct 2019 16:23:22 -0000
Content-Type: text/plain

This patchset adds Vim indentation support for the BitBake language.

It supports indenting variable assignments, Python and shell tasks/functions.
To accomplish Python indentation, it uses a hacked-up version of the Python indenter
from Vim upstream. The upstream shell indenter is used directly, without
modification, however in the future it will be necessary to modify the shell
indenter to properly support "fakeroot" shell tasks.


The following changes since commit 94f6b31befda5c496f65e863a6f8152b42d7ebf0:

  build-appliance-image: Update to master head revision (2019-10-09 22:28:50 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib cpl/bitbake-vim
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=cpl/bitbake-vim

Chris Laplante (9):
  bitbake: contrib/vim: initial commit, with unmodified code from
    indent/python.vim
  bitbake: contrib/vim: Modify Python indentation to work with 'python
    do_task {'
  bitbake: contrib/vim: More Python indenting; move indent file to
    correct directory
  bitbake: contrib/vim: Special handling of bb.fatal
  bitbake: contrib/vim: don't redeclare indenter
  bitbake: contrib/vim: renaming & comments
  bitbake: contrib/vim: indenting for assignments; tweak Python
    indenting
  bitbake: contrib/vim: handle shell indenting
  bitbake: contrib/vim: Add copyright and license notice

 bitbake/contrib/vim/indent/bitbake.vim | 342 +++++++++++++++++++++++++++++++++
 1 file changed, 342 insertions(+)
 create mode 100644 bitbake/contrib/vim/indent/bitbake.vim

--
2.7.4


