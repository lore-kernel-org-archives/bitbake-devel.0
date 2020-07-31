Received: from NAM11-BN8-obe.outbound.protection.outlook.com (NAM11-BN8-obe.outbound.protection.outlook.com [40.107.236.79])
 by mx.groups.io with SMTP id smtpd.web12.188.1596234890924982805
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 31 Jul 2020 15:34:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=eu6/EQS9;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.236.79, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOvzMAfqbMo7U1jiOMKYrJ3uplpcdiCMx13+kqfDjcua30b8DBQtbrbIM4clvWQoQ9ilRPjKI8Mtrvv/zDhfScEnjcYXpaie10mCn5oy6L6R6VvNM8c8rdNfoxm+GPqU2COkCp3kJamzj94EOXA+BaHGt/FxsmmXS84ezt0oRRazI82LSYGsZwPj3ZwFtKo/dHZIstu57prqyqXI1VFlaSivJw4kHceXxcpWW6e7CWwjzTQH+9Q/mmHsWCqzfdRfILGcU5FTQxNpo8KUT/issCOe+3DpfIwaUl/SpKVc9ZA5wEcbpg3aAODbUK9gMZyovo1w/SpVetj8ezVDuTVTXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IeY0BvslTBTxc+/dLknP8bsD6ISuS6SjWeSUxUSxrQ=;
 b=G2rAtjnH4PSnBqiyrv3g/LJH2dMjgzeFLx07osNHfGlELOtCswjwAHGfgiKktqidxFBh4uIXsfcBspU/RCWqByEx0rtU27vpLg1sN/YzhvVUMwjvBhP2IR9dbaz85elTVH3baVPWLcI2O1qsLZ/85NE9sXN5bQiqOmKvdD4w5R3cL5eP3AzdXt1EsJyFTrmagKOwyESeMrEiIX+W1T5jgipf5mEltxDSUFwYSD4i8fh7ad6VuzyQZGxIUgjSW8In+txXLRpFsQx4m/AkH4eeRYxN0BibyOHYL6CgupCPzwSyR98NWFOxe/l8cVMexBoUF0PFqALnVxXB8OzS6eEIFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IeY0BvslTBTxc+/dLknP8bsD6ISuS6SjWeSUxUSxrQ=;
 b=eu6/EQS9SDa1OcLW+BKCSbuvUVNL4+D5171Ml+KS2uioNgCfEr8OaumObEHwKWrACNHzfBptm4IiyWVPmJnY+Yp9TCKPesAFHHBoLlXH0m/WftH+7AEeR4zs6stObC33tM8A1pZ9mTVYO2JR7TTIS7s9AHg/u5HT/iDLeFvNkWe70fhh7oQ3BkYctU+D+FI+hC8XqGWvZlIX3+8yB/zqU4wWy5R6XPZLoL697HHBw8rIhDZmQuXI0WASAyczs42HkVkCdYH8a7zLClMsuLUWhDH/J1Uq5R5aock2easoPiUzuD5oJ+WVo3T6v59WiJ/whSwxI+CYkylkT5xE4nwbPA==
Received: from DM5PR07CA0119.namprd07.prod.outlook.com (2603:10b6:4:ae::48) by
 DM5PR12MB1452.namprd12.prod.outlook.com (2603:10b6:4:a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.20; Fri, 31 Jul 2020 22:34:48 +0000
Received: from DM6NAM12FT006.eop-nam12.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::81) by DM5PR07CA0119.outlook.office365.com
 (2603:10b6:4:ae::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Fri, 31 Jul 2020 22:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.34) by
 DM6NAM12FT006.mail.protection.outlook.com (10.13.178.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Fri, 31 Jul 2020 22:34:48 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
 15.1.1713.5; Fri, 31 Jul 2020 16:34:47 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 2/2] build: report correct line number for failing Bash shell tasks
Date: Fri, 31 Jul 2020 18:34:42 -0400
Message-ID: <20200731223442.102095-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731223442.102095-1-chris.laplante@agilent.com>
References: <20200731223442.102095-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg3.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28df2c06-aecd-4f3c-6ad6-08d835a1eef5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<DM5PR12MB1452A7BB8EED1C5F21DD88C48B4E0@DM5PR12MB1452.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Hi9UT6r7lpFyjwMZJtNYe2ZpUqC8LD8VrTS4fOYWlNlbVb2peEoK15rI/F9uW9Nut+XVB4iSu7nOs/yA6mcAdjepeOeuXfek76GsLW43cj0e2AxTc+pxu0nCbuLfzELj+kusoVcQ6Nn/6ADFjYlS0tRedt91U9WBy366K3Gx/PNor/03SIMY+o+BMqVx1gm/FNaxLrw6XyOSbSUV/pKz5vBwA/xzl0pUoXXVdTt/XsjrKKQUnUkTqyg8YwL+S1GGbLzUsDZNa2hF68KWjRMJmn2RRZ2tDsPS5zg6pX3W2553uT1fFvALuQ8O0DsRQXrt06YD3Xold5WR0fQ0qUrzfSHKB/yApUkMunYM1C2BYihW6ElJ818mC4btD3QSWXHXo28bLQQiG3gm0mrOkfnhhUit1TbYUhi29BAmGATGzUk=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(396003)(346002)(136003)(29502001)(46966005)(8936002)(36906005)(5660300002)(356005)(26005)(82310400002)(478600001)(6916009)(186003)(7636003)(1076003)(70206006)(83380400001)(316002)(47076004)(2616005)(956004)(336012)(426003)(82740400003)(36756003)(4326008)(86362001)(107886003)(8676002)(6666004)(44832011)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 22:34:48.6813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28df2c06-aecd-4f3c-6ad6-08d835a1eef5
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT006.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1452
Content-Type: text/plain

For EXIT traps, ${BASH_LINENO[0]} gives the wrong line. We want
${BASH_LINENO[1]} here.

Before:
| install: cannot stat 'source': No such file or directory
| WARNING: /home/laplante/repos/oe-core/build/tmp-glibc/work/core2-64-oe-linux/libsolv/0.7.14-r0/temp/run.do_compile.101649:1 exit 1 from 'install -m 0644 source dest'

After:
| install: cannot stat 'source': No such file or directory
| WARNING: /home/laplante/repos/oe-core/build/tmp-glibc/work/core2-64-oe-linux/libsolv/0.7.14-r0/temp/run.do_compile.101649:115 exit 1 from 'install -m 0644 source dest'

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/build.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 977b02fc..6ad20ce7 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -310,7 +310,7 @@ bb_exit_handler() {
     0)  ;;
     *)  case $BASH_VERSION in
         "") echo "WARNING: exit code $ret from a shell command.";;
-        *)  echo "WARNING: ${BASH_SOURCE[0]}:${BASH_LINENO[0]} exit $ret from '$BASH_COMMAND'";;
+        *)  echo "WARNING: ${BASH_SOURCE[0]}:${BASH_LINENO[1]} exit $ret from '$BASH_COMMAND'";;
         esac
         exit $ret
     esac
-- 
2.17.1

