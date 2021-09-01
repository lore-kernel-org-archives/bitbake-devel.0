Received: from NAM10-BN7-obe.outbound.protection.outlook.com (NAM10-BN7-obe.outbound.protection.outlook.com [40.107.92.48])
 by mx.groups.io with SMTP id smtpd.web11.973.1630525508093748984
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Sep 2021 12:45:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector2-xilinx-onmicrosoft-com header.b=bWlL6Bta;
 spf=pass (domain: xilinx.com, ip: 40.107.92.48, mailfrom: vishalpa@xilinx.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VA7w7nrOcs8qV0IKvqCRFphi7AQ8AfXiHmXNOy4Jsne0j29UL7T7CGF+YxqyeXn5I8uIGa7yt/EuU3t4SGy03L0dFOO9iDQarbbtW2cNRrjVllqbrGRMuyTSsZ3NbvMO58qsQ4zOjuGvYVQt1BJk+SFsuZqrhbZYcL6jav1rkOA7p4jrZC5YULFuM9sfL2t3OkZlfxj1l8mwxXjgHpii9YcNqiT2FrA/7tDeAhxeteR/HFnKQS3Q+tIsMYdQsYN9P0D8W7HGN3qTbj9QVdunZ1qCkqaovoeQGsOVfbR5oT9Wr/+0SK+wPfWEkic27YMqexSILHSDDnyyZW7tZR3DJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnFV9E9uwkNtAtagLb+Afv0axu0cEF0hpDJE+qMPa9U=;
 b=iG53bJZbLzQo7dg4o0KbU9k507/br3OeKSQcGZv8ylEPOJJjQZukg2604D/5jKhFiUnETgAkex9tNq4D3P63s95pDgh/AxC3+np9nsj0tQ0WAGwRoBTffU/Bq/ytAZ7uR3edfqVvGcgraz17hF1cOblre34AKgEdOaANplveJy3QxrhI1UKrMwDcPWF6otppSooyvTFq53iShY3WarXlt8riNlyLDxXpD+5POmhWWcuMTHuP85yXcmA25a2AHJzMW6NDUML0kFq5hrmAF7xEu9UGT6C2/FK5ED9wJ+dwG9UbdeCjkLM7o7HnczKSnufHo9Sw/oLWyh+Qijp9T7DRKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnFV9E9uwkNtAtagLb+Afv0axu0cEF0hpDJE+qMPa9U=;
 b=bWlL6Bta4bUWI0CCUSxkb6321r+qYgl36cKJN5JFo8VvaPhKzwFIhiC19Tk+R68jNsSIk/JPnRm2PHPIovzksj3M08V4xYIiemhXzg+l4GQcjXPb+qmQ+ZlzUtOjsaChCaAjQ9wEn6WnuIJCLSYnPlTXypLbJlbjPMCNRXBqguM=
Received: from DM5PR06CA0034.namprd06.prod.outlook.com (2603:10b6:3:5d::20) by
 SN6PR02MB4845.namprd02.prod.outlook.com (2603:10b6:805:9c::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.23; Wed, 1 Sep 2021 19:45:04 +0000
Received: from DM3NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:5d:cafe::b8) by DM5PR06CA0034.outlook.office365.com
 (2603:10b6:3:5d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend
 Transport; Wed, 1 Sep 2021 19:45:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT035.mail.protection.outlook.com (10.13.4.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 19:45:04 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 1 Sep 2021 12:45:02 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 1 Sep 2021 12:45:02 -0700
Return-Path: vishalpa@xilinx.com
Envelope-to: bitbake-devel@lists.openembedded.org
Received: from [172.19.2.60] (port=55656 helo=xsjvishalpa50.xilinx.com)
	by smtp.xilinx.com with esmtp (Exim 4.90)
	(envelope-from <vishal.patel@xilinx.com>)
	id 1mLWAQ-000BYB-Rx; Wed, 01 Sep 2021 12:45:02 -0700
From: "Vishal Patel" <vishal.patel@xilinx.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <mark.hatle@xilinx.com>, Vishal Patel <vishal.patel@xilinx.com>
Subject: [PATCH 0/1] RFC Bug in PREMIRROR
Date: Wed, 1 Sep 2021 12:44:55 -0700
Message-ID: <20210901194456.2642587-1-vishal.patel@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81a34129-9529-4365-759e-08d96d80fe71
X-MS-TrafficTypeDiagnostic: SN6PR02MB4845:
X-Microsoft-Antispam-PRVS: 
	<SN6PR02MB4845E31DDABFAB74CF5148FEAFCD9@SN6PR02MB4845.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NJcrhTwXd9u6ks6wA/IkXPm9j9PT03nISArGZNH0YXYrfNOshXE83790S0S2VyFB1p8Tl/rjaTuz2AEK1CTekLiHcugAdTluzrmGF3JR9/aMKIC7bdWQhewywc4RVzljdmKsaEjlLafV20Kes7VaFlwaHByyNWOZDgUOQl+vYzbnktoND+ddhsyNwAcZMlSd3f9THM9Hdr2JvK1s16/cVlmGsOuBOD9nyTcpeVnRAPqUHAEH6HfMgp9Q0cRu7016EOA/eW+AHg2nrveMT3/jgsM6BzuNlwQu87ea82J1kReYmF+QFSdEXafAMrnrXoOx4yiDs+03Bv82YH7tkYPtGedr8CrxyxFHCLvyUBDCosyGsEnXSPGtv7I+vCWHLCL9GTte2t8HrDUOLNnHHS4FjdlxJMT1vYdRLeNSTUaO2ZWQe+uh6M7/1O4SfAJGbtmahTr4kb381Fj4ot3+1R1VFA9SjEHiqni6bQsdr2oJzb7yxDH8w3H61LiHfQwGzZRSQsn9k/n1dG/6O3ooKz6z30K84YOeLIkYqu4DVRC3oE6FJgjnGtTVeSwAkocHPhmGbxQYQ5Qehn2edllcDrSJ0ofUndEjJvMkyhmNC8xlNfniMmIMp15ZCM5jzc6xWt04sGLch+9tHsxhD/XU9BNet04XZ9Pxm1RBD87kxLOdg4Imb6PSYpL9XNEB7kc4qYfTnH9IEE2/mm7A/PAVuCFpFJJxGGH9UQ6IIskYTvQ1SNQ=
X-Forefront-Antispam-Report: 
	CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966006)(36840700001)(70586007)(5660300002)(9786002)(70206006)(54906003)(36756003)(2906002)(26005)(1076003)(7696005)(478600001)(6916009)(82310400003)(44832011)(316002)(36906005)(82740400003)(107886003)(426003)(2616005)(8936002)(8676002)(336012)(83380400001)(6666004)(47076005)(4326008)(356005)(36860700001)(7636003)(186003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 19:45:04.0806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a34129-9529-4365-759e-08d96d80fe71
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DM3NAM02FT035.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4845
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

I think we found a bug in the PREMIRROR system where if both a remote and l=
ocal
PREMIRROR is defined, as well as BB_NO_NETWORK =3D '1', the system will fai=
l with

bb.fetch2.NetworkAccess: Network access disabled through BB_NO_NETWORK (or =
set indirectly due to use of BB_FETCH_PREMIRRORONLY)

instead of trying the next PREMIRROR which is a local file:// based one.
The attached patch only adds a test case for the issue, but does not fix th=
e problem.
If anyone can point me to where to fix the problem, I can work on this.

Vishal Patel (1):
  tests/fetch.py: Add test case to verify PREMIRROR with mix of remote
    and local

 lib/bb/tests/fetch.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--
2.25.1

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
