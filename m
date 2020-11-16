Received: from NAM10-DM6-obe.outbound.protection.outlook.com (NAM10-DM6-obe.outbound.protection.outlook.com [40.107.93.76])
 by mx.groups.io with SMTP id smtpd.web11.29352.1605493299398007420
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 15 Nov 2020 18:21:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=hCKv4Jh2;
 spf=pass (domain: windriver.com, ip: 40.107.93.76, mailfrom: hongxu.jia@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfLnaYOz78wV5hS+y5DGp59qIqpAVUE3VtwpATak/5ibXVI+GkTJTU+e3FMPBgNghV8K+cjsk3Z4lmFZxO+V4itaJOdnc+iJnWJlqKJqw63ncw1qnVYIkvKrfq3ZqHxqaUjXiPr+kTVrOlLhuTdNp//JlVyIhnAVfZIl7RetNZN7ymYeCNmrVWXI74W0Z6bj+K1/TY0Hk/Q8zqH3StXX9WL5HpxWgIjkWvMx0rX0xAkSUtxsZ/ACk2in916yuRaYXBZtBFfFiBpOcdno7H4Kxh+ka6zF6hVvBPeZ8iURyig3uYa2jZNGz0XlFau1UaOCrGph3cnXvabXUTrmw6lllw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuYEBZZlHMD1bWKfZbjzUi2ZROdis0I+g0kvCVoCFVs=;
 b=RmfBCnBH5lbqu0vLsaxx9LvwqreTxeGerHwH/+dPxOMOOh+SpvBixhDDMPtlF+RfV5oxkzBaifrbHWz98hJ8i2j2TRYLU9KgrGVH6TR4fbW4erdYLZ7HBJrMuVi+yzwFpBJw0PBQf7iWq+IdM5wbasYtDRQRulRikLoDON8XLDi4r7aHc2d6eepyt6Q3FFv7K9PcSjFcn2a6kGYznF/5mDPbCUJo+hJekYuRmsQ4Ujn3tRuiAJ0eR6yAbUDfbncAn35D0sPcg1NCnraPVkMnQXsJVNSF8OhExe2eH1ts066U82Ft2rc6LywfDFHndrbcCu58dtHGj6SV4Qo/o49ohA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuYEBZZlHMD1bWKfZbjzUi2ZROdis0I+g0kvCVoCFVs=;
 b=hCKv4Jh2TFyYvEcpQ/p4vUdKlKPBaTWb3ZIk5Bu2ckjo9PtLnN/rn0j97+U/SUH86qKLPQnQYhf0nLbITSJByjZY6fl/+TaCrD1QPubfmGOmDIdxRtL/VZniz4tzD1Jy+1wPdHRPnYWYBoO1bpQPiYiLCcGzZUi7GAXUraur20I=
Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4369.namprd11.prod.outlook.com (2603:10b6:a03:1cb::25)
 by BYAPR11MB3655.namprd11.prod.outlook.com (2603:10b6:a03:f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 02:21:37 +0000
Received: from BY5PR11MB4369.namprd11.prod.outlook.com
 ([fe80::4138:b781:db9d:e6ff]) by BY5PR11MB4369.namprd11.prod.outlook.com
 ([fe80::4138:b781:db9d:e6ff%5]) with mapi id 15.20.3564.025; Mon, 16 Nov 2020
 02:21:37 +0000
From: "hongxu" <hongxu.jia@windriver.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org,
	chris.laplante@agilent.com
Subject: [PATCH] Revert "bb.ui: delete __init__.py to make bb.ui a namespace package"
Date: Mon, 16 Nov 2020 10:21:25 +0800
Message-Id: <20201116022125.38677-1-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.18.2
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HKAPR03CA0032.apcprd03.prod.outlook.com
 (2603:1096:203:c9::19) To BY5PR11MB4369.namprd11.prod.outlook.com
 (2603:10b6:a03:1cb::25)
Return-Path: hongxu.jia@windriver.com
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HKAPR03CA0032.apcprd03.prod.outlook.com (2603:1096:203:c9::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.15 via Frontend Transport; Mon, 16 Nov 2020 02:21:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 100b6ec7-ec34-4242-5441-08d889d65863
X-MS-TrafficTypeDiagnostic: BYAPR11MB3655:
X-Microsoft-Antispam-PRVS: 
	<BYAPR11MB3655F100C9F49B6E4FD329C394E30@BYAPR11MB3655.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:161;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1evZKaaLywxL/8JO+hbkMNHR3TC7veGuMYhnlTzh4erv1Z6rqPUHRuygwuKrbWcSv5jX4yUuqzSEZgcDcl1j49naV5mRbJgVORc/+nqRjdp0QtV0g0EUn45ARBVNgc6ki/un/55WTIegDxD+QHn0xCgq62bTUE9KU2kWxxWu5dec49+oHcfAs7Ja12nmqtV6Pg+AABbtGNcpytijdbQxL1SUvM3XWPrqZVJ27Lg9H1rZY0tr0wYfJjkk/ZMDhYOIgBJykEbIYLnQ5mUzTjimOAamF6LfD9Ab/B1CggoxmFqX0IlBhyieohF8srzAlcGq
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4369.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39840400004)(346002)(396003)(366004)(136003)(956004)(36756003)(316002)(2616005)(5660300002)(1076003)(86362001)(66946007)(16526019)(6506007)(83380400001)(66476007)(44832011)(6486002)(186003)(66556008)(52116002)(26005)(478600001)(2906002)(8676002)(6666004)(6512007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	5qUbxIIO+GudieiKG5jbPre5q+pFcqLI93n+10uIVvBy2Iui82KIJE7C893bDVsdDC5EPdki5l3Lu04Hj6Ca3Ovh6RBCpS/NwojqPDw/ZhZYYTNp6IlQhuq0PLWELQnBpslBPA3HSgQwPU/0/tzaTV8h2KtXrQaio5TugtApNtEMtGIR9ppZeG/L8YBbU8L5cSP8lhZcoog1qEwJ+CsL1HZ2zEyQXQoM0qRItK5EiO+8o2dkrxy8IPTGG1fzt9u93fiW+2H3MfISAdcBSEObrmPsSTeGz1sB9Qg+ud/TIF4ksj+SjIOlBty7V7MvZS+9OiPUBjjwGnRnqzgEpINQSGyvezRFeTSjer7+PByeF/mmUEdl9FHmL2MO2yREz5TulravvogfOuiEx52+k0KJ56HGTEeiVsJs+uxUrRI/fo1A2bVoGOb1cV5LJFeteoSxczGK7kcbblxiz2ojW3UI771no0At2w0F+EINSVWT0bFMa33Bf1SFcGmo7APxBlB4HVXRo6heM9lanBpClAVRk30rx+vSRVu2JT2uA18jC9pJMxNAAqJZnaSe+KU0J4MX+VvnvOVTL7YyMOqFlY5dPyO5m6BvItqHwk2t84qIngbqUP+NTG00WLnmh937ghECmDU9p91mc43a8cfPgr9/Rw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100b6ec7-ec34-4242-5441-08d889d65863
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4369.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2020 02:21:37.3955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oE30xG0oMtGMP64J+y8CTmWFGqRHnOQF3A3Zt/prHlSq/Nr68zQ3IlZwZXv4Ww+j5xrl4p0thgJzfZGU1sJP1YU9sxPZzgrl4FBEkhMIrCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3655
Content-Type: text/plain

The commit [991f92b4d bb.ui: delete __init__.py to make bb.ui a
namespace package] caused `bitbake -h' failed
...
$ bitbake -h
Traceback (most recent call last):
  File "/buildarea/raid5/hjia/community/poky/bitbake/bin/bitbake", line 35, in <module>
    sys.exit(bitbake_main(BitBakeConfigParameters(sys.argv),
  File "/buildarea/raid5/hjia/community/poky/bitbake/lib/bb/cookerdata.py", line 27, in __init__
    self.options, targets = self.parseCommandLine(argv or sys.argv)
  File "/buildarea/raid5/hjia/community/poky/bitbake/lib/bb/main.py", line 297, in parseCommandLine
    options, targets = parser.parse_args(argv)
  File "/usr/lib64/python3.6/optparse.py", line 1387, in parse_args
    stop = self._process_args(largs, rargs, values)
  File "/usr/lib64/python3.6/optparse.py", line 1431, in _process_args
    self._process_short_opts(rargs, values)
  File "/usr/lib64/python3.6/optparse.py", line 1536, in _process_short_opts
    option.process(opt, value, values, self)
  File "/usr/lib64/python3.6/optparse.py", line 785, in process
    self.action, self.dest, opt, value, values, parser)
  File "/usr/lib64/python3.6/optparse.py", line 807, in take_action
    parser.print_help()
  File "/usr/lib64/python3.6/optparse.py", line 1647, in print_help
    file.write(self.format_help())
  File "/usr/lib64/python3.6/optparse.py", line 1635, in format_help
    result.append(self.format_option_help(formatter))
  File "/usr/lib64/python3.6/optparse.py", line 1615, in format_option_help
    result.append(OptionContainer.format_option_help(self, formatter))
  File "/usr/lib64/python3.6/optparse.py", line 1061, in format_option_help
    result.append(formatter.format_option(option))
  File "/buildarea/raid5/hjia/community/poky/bitbake/lib/bb/main.py", line 54, in format_option
    valid_uis = list_extension_modules(bb.ui, 'main')
  File "/buildarea/raid5/hjia/community/poky/bitbake/lib/bb/main.py", line 72, in list_extension_modules
    pkgdir = os.path.dirname(pkg.__file__)
AttributeError: module 'bb.ui' has no attribute '__file__'
...

This reverts commit 991f92b4d15b0571b6a540964e5216d1b9728539

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 lib/bb/ui/__init__.py | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 lib/bb/ui/__init__.py

diff --git a/lib/bb/ui/__init__.py b/lib/bb/ui/__init__.py
new file mode 100644
index 000000000..4b7ac36ca
--- /dev/null
+++ b/lib/bb/ui/__init__.py
@@ -0,0 +1,7 @@
+#
+# BitBake UI Implementation
+#
+# Copyright (C) 2006-2007 Richard Purdie
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
-- 
2.21.0

