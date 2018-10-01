Return-Path: <laurent.bonnans@here.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0136.outbound.protection.outlook.com [104.47.2.136])
	by mail.openembedded.org (Postfix) with ESMTP id 0561079943
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  1 Oct 2018 18:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmcs.onmicrosoft.com; 
	s=selector1-here-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=4gp8c7mVBi6m97NT/qq81dyYlLMvBhRawC76OB0DPsY=;
	b=n/uSRHKnOCrLiOnLtSU3xvLvdLdxv3wdRSQSzqH1xWUeV5I7Ibo1YJvJes0SCAph319TJmFWVF+CVAfPN5ib0q1hPfnLeNBTbBSRFHL3047fJSzXv7/1sNyzu5I/NsHKdg457B+4ChzfJO3FJMh5Vk9HkLD6/1bsIB4xuEKlkK0=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=laurent.bonnans@here.com; 
Received: from herelb.internal.advancedtelematic.com (87.191.159.149) by
	AM5PR04MB3283.eurprd04.prod.outlook.com (2603:10a6:206:d::26) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1185.22; Mon, 1 Oct 2018 14:52:42 +0000
From: Laurent Bonnans <laurent.bonnans@here.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  1 Oct 2018 16:52:13 +0200
Message-Id: <20181001145214.19329-2-laurent.bonnans@here.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001145214.19329-1-laurent.bonnans@here.com>
References: <20181001145214.19329-1-laurent.bonnans@here.com>
MIME-Version: 1.0
X-Originating-IP: [87.191.159.149]
X-ClientProxiedBy: HE1PR09CA0080.eurprd09.prod.outlook.com
	(2603:10a6:7:3d::24) To AM5PR04MB3283.eurprd04.prod.outlook.com
	(2603:10a6:206:d::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71f714a2-f528-42b8-5cb7-08d627ad8a84
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
	SRVR:AM5PR04MB3283; 
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB3283;
	3:HybMLvPy85ds/dtuWirQk+YYBpyHjhbwPVM9eALQPm3suzTaofM0fBrigU4xuGI6I3F7bI8hjp8cGwrgF6Ky40TrX4yT4Rgeh5jcmyJlVeTCJLNLvSEsMApqcOM6hofV21sTTuHiV1aX1fP73+6cbxQ5io1U+0FUnIkLZ87HX9oAUZTstLTzw7u+wf2d0MwOhoeMXJ/uo3pIMyN8r+TGpcMGirvgSPjyD9/FOyaoH8PtlA2mLOo2JymbBt7M1tBu;
	25:OoMX81Q+jMZ+x/y9eFTUNc39uPZBN7NT6H8pyZysvKmN+hINAKErM/npm83f190wFddR8j4g8LVcDGuSQfKzjsB/1qxHVhMslLR330bJYMo7Z871EhcQE09Yb2WRxlHsG/wXLqT4tCzdXAup8YaeIbIvF6ZSNjAwWs+mp8PTL7RNXoCJ3pDK/qpnGOAwdmX88H+yw3lCTAJPdbJuaGMwv3XVMaVFoaz2Mm0/IemHZ8banry7L6vvKkWY660FVP8w92RkDY5epluH+xGABZciMu0KoSAUAGE+KZRT1a7tj4MpYuSRrXypTv3NV8+eK0V5JfSySAyhZOwnjOstK2imtA==;
	31:MQ8gM6pu0mra6o6ZlM8FjO5GwONRKFISolVNlRCsTukh85BwDksTBCkJTj1AfnyWAZ/a9Y4qR74akQESXHAQUrUpuA7xUqiKtKYBtH7BmYYfwLkyNmHnL2Y9ecZyZcQF7HtqY487nS/kI2naYfvTJyLw4T2cJTfDV3VsEnSnj4LRVuGBXeOLXu4ZpneAPeaZWd8zDc+ZtcTZWovHE8MhjhshkNm1CjIBQ9bcZz3O9QM=
X-MS-TrafficTypeDiagnostic: AM5PR04MB3283:
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB3283;
	20:Pb9D32RH3m/R/fpDKitTbxw/iQ5ovlRw88UrOZXkg1KhzAuJjFe//MAkZ+Y1z7OvckCJyZfOkgt8VqSSG0PM5ssr0lHIJ3wcPZyLGSjTjgk9wdU3isrtH/xMwBdAeFInVGbTqxRJpwvFPI+0pYJQnAAquIAcuPbojU06wtOVAJZP9buvNRpgepeFxTD6DTpgUQnQ+O2qujJ35CfgBr5JGSo4GYfFgy1nHFIDkv2iIBsOtEwX31YwBwsrCWHWlD1Rr57iypPafq7YrO2k5TjqFc9zKdXrnr5I+lRoe80H9setL62/iW8FcDt2E6/0FjvYy5vrhyewOLjwdwjwlHvLy1ebCHqEdOrrSJCMluf3LfntqIXyEx5phJmozMzZyVD3z/waG/2NXFzOzd/+y3+Iznh0DywW/t+6KH98SPs08dr1nVeyi21a6lPQJqjB3EY6slJgAc54I8IRIj8gN7IZczsoWzlWG/dKXwMCDi3xoF1ACHqm9T/RIx9bKCxj7Ieb;
	4:OeDcFOkM922Fg8NgxI3OkeXI6TyUrgERkSUHIr+oXahXSWPbNVfxNhamlnNpVHnPR8+U88ez2Ddwyhm3IwtqCq1LjJg2/tognOS6Qb6bgK/14qajAv1r75kfeORCm3GHzpITSPZLwk6xV8rV+m0N2L1B/6z97EqwR5l5Gy4G/B3HWZTXk4tfLF+9GyJknZfZC8la6+s7f5RdRUgjgT/9TsrqVGQk2qZ/ZJxgDZTVFWNV+16Uilf8OVNZZuOqoSSvKZ1HvNUWXi8Sz8nbHooUBxKs+UJUqS0IiHAKv8S5IqSrjU9CJPmzlzq4gdzLf6yPkY5MlvZMccDxBD7ePIyc/hb7zreaLnjhgFi9D8uSijY=
X-Microsoft-Antispam-PRVS: <AM5PR04MB32831418FE446740D5B4326F85EF0@AM5PR04MB3283.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193)(87047540314649);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);
	SRVR:AM5PR04MB3283; BCL:0; PCL:0; RULEID:; SRVR:AM5PR04MB3283; 
X-Forefront-PRVS: 0812095267
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10019020)(39860400002)(396003)(366004)(346002)(136003)(376002)(199004)(189003)(7736002)(76176011)(2870700001)(52116002)(86362001)(68736007)(2361001)(486006)(2906002)(6116002)(3846002)(6506007)(386003)(51416003)(50466002)(48376002)(446003)(105586002)(11346002)(106356001)(6512007)(2616005)(6916009)(66066001)(1076002)(956004)(47776003)(44832011)(5660300001)(476003)(2351001)(316002)(34290500001)(107886003)(53936002)(25786009)(6486002)(305945005)(186003)(26005)(97736004)(50226002)(81156014)(81166006)(16526019)(4326008)(478600001)(8936002)(8676002)(36756003)(6666003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM5PR04MB3283;
	H:herelb.internal.advancedtelematic.com; FPR:; SPF:None; LANG:en;
	PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: here.com does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM5PR04MB3283;
	23:izsA4FOIbkSQ4woGiaSL5nU38dSmHccOB6NrMam4c?=
	=?us-ascii?Q?WdnsT4e2v/q6hswaJ09V8l3TmaBd4tYpUZt38zZJn1X01iKra4QfzaRWg/4y?=
	=?us-ascii?Q?oBEYnR0DjFse39xGeeAcF3peI1ZpbH73fBiC8LCahH4ssPrpBo5dHNmKLnsN?=
	=?us-ascii?Q?/UgSbhoy06EvMRX/k9ziC08SIYgGhCSUTW3AJ4mGvFvBlpifQ7JLtIp7qz78?=
	=?us-ascii?Q?UrARzxke6lxaabFN8iChgtUKGUvXtDlkj3vhxJ9AyXskKf/oUe+9FdRpyTrR?=
	=?us-ascii?Q?Xt/BfccRbny+jTfx5gn2L8co8DOJKveDhEiIuhTkrFp0sqrSmuyGPo78UvgS?=
	=?us-ascii?Q?77zsJsm++o1sX8ZLO59oMRAh18lv6aqbL86ufx5XErgCC4Yug+B+41ToW8ce?=
	=?us-ascii?Q?R7pUO+Qi+JoJp/zWppBIGYMXcDOi209+gv5d77Hkk3F9V7p3a9V7P+mQ1/+7?=
	=?us-ascii?Q?9jgbWoqkz9Gg5jd90k20BWr2hDx5mK1RGa0sSNq81WF2cZS7STX+rbyJj9+G?=
	=?us-ascii?Q?/W2ZG/xHhQSuWJXoN6VDodf41tOSUpMH3AjnAJS5ZVFEF5DDggqB1PXV/89R?=
	=?us-ascii?Q?LZcrYKOosHsFIITg1S+H6Ynnp3yZ1T4Z7LESQQYH8OA0yCNTD1q3YSgMm6iw?=
	=?us-ascii?Q?ZNZL7e1MbLpXPbnfDFuxCeI0OQzA7oJLkYLrt45RjoH12wuipqXAZjxOqzZy?=
	=?us-ascii?Q?VE2Gc9u4hSeYwOcOqF+MZ9tMxHtnJz3KShwsZlLGrHzqYtykJXyoXXlcm+t8?=
	=?us-ascii?Q?yhq62O/gz3tt+aYnZKS1DLRrZzgIA+1EZY2xiUadS+EnPHJ7HxPQmCaBifkK?=
	=?us-ascii?Q?G2C4Rslscchnmll0xdtxK2WLQUypKUCjSRUF4oSVOhYoph3lrunRh4SuTO57?=
	=?us-ascii?Q?sVmsSIKfofvkz2ZimOJnULCcPeWJHQvLU2K8ukgIrfVaV9M6rw9UYPbLn3Gi?=
	=?us-ascii?Q?uakbe39cZ0wxJt+JvFkVMTFRnQc0meBsCnEehyihFZ4JpjRwtrVmjHfWU8G+?=
	=?us-ascii?Q?d+E6p7uBd5iovu0ohrVZXGmq6B7IXZ2/Pe6mVxlMbf9gkoN+tEblmzWV86xa?=
	=?us-ascii?Q?0Xy3R9cAIj5vThKoITaY6AiwGl33HI2Ct5Ol4Oz5c6pcgj4JQI7a4tfkIJxf?=
	=?us-ascii?Q?CDrvTYWfXOPZIfduSjYohjVO/n6MsZgFQK8teVicmRIBoroFIlFWjCY9g3/Q?=
	=?us-ascii?Q?K/uHMbdsr9rkuGVy/IwA7ccXBFV9N2uC2NXD8KetX89eTB3+nYBc8jLTKQdB?=
	=?us-ascii?Q?X26Wdf/4g9S3vDJ7Y5U6wrd4MzT9EHOa+FtrsW5yKh8B4cg9u+9inWWyPax4?=
	=?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: cmwO5kSw0UfPvL84vTLHyVjRXAvkNiUQWfcr7AWPg1PRdaM2nDUfpubBTYdtlG29fPYYftD01HVoN3XlBywEN22tCRyXBT9vgapkIkAlLwL38I9OIj7gCPRxCuVfpBrTOqj9d/1Xh0NB3qHs+Cwts8DFcTSbmsgNjxF6vglSlqLThHF2wppPy9zj6KxfhrXis/6x2cL7EM5coSiqpsO0aR4tnnL8GS4ViJS7Agu39H1nGADMaI1Y920ZMpsxbmeyRIC1YO8e/A3k7CMOE6D1Vu7BYH/FeeX83rOZQzsfn3/Q0EA7TT61b5YbZrllZ9nTtPs7PsNMWVAzkQtUnSS1alPfwyyHSPRFC7JhUvsxn/0=
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB3283;
	6:FzE9kptbfD+pk1LHvXVokTE33uO0tzOeJjW1b99s+fzXo++ox7LOUcQ/u6FRKurx1E4f5Ho5/ymciwyT9lM+ESx1Qb0uTdwjee+U4MbdFCrq+Jzvs5Jpn4DHLqJJqT97FHRZ42yeqIpBNe+LKiQfX0JUn0Zp6G0A2PHB6RbWWhl4xo9jQpazM7Pa4Y3EXurxMnFP0wjO3hS91kLxstPfDmXnbTXpGAQGhCdeT5HjB7BAsHiVCKaEakWt6Dqthza5t0HQOgdKUTi1fLiy6/uEtppj1fKBrTXV5QMnHLV3Bb10ZbLXNeHjq6hCUdQ/bfBLQ5cGFImewFvqM4kRfBIGhs9M0C75KmKRoG1uSvjfDouQnQr9C+5Iodk6tx0YonVSECWCrtOKBnXTNUHP3hBctEez5yf0rpi9Ps/sBcvrRPHdqH+pDXW0oGF4diRRfPBSim+2g6uRDCw3y8WQpiYk5g==;
	5:PfvEHeFj/KgzKoUjMBBVUYFwplUo10XEdUzm9Dh5uWXX2Tvv8qX960sbrHolP3DOWnxcZkZBUY0MXhQNB+3oQcJWBLHBhdsJvzchnneo+VSJVv3b1p/mo0GlqJ7W3ktBnuXgJtJIlQGlRHfHyTWAYC5dyfdMbF78/ylWXWvHBCo=;
	7:8DAIuJDSUTcrNCx4v7O+a256Pxg4BBRcyZNddc+ZMhPPuykrdnId0dQhywnUbm2lFd5XL1WZ5x2STr2zFRnpO0FVC1zB7tJ5SdPYBDerdBi/JUdbHdz5JFGPRpmxm6XOEXb6gKbYfPmww5+qQkqnPH7abi21+BdW7+yMnyjLcTWHqy0Pw3m/S9bvAhciuw/04nFL3EkLnK7+BmD/DCg5DkogDSfmh9iPQu1Ibcm8SyrnsruXLsEqQQYLj+Ljd3aa
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: here.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2018 14:52:42.2917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f714a2-f528-42b8-5cb7-08d627ad8a84
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d4034cd-7225-4f72-b853-91feaea64919
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3283
Subject: [PATCH 2/3] fetch2/gitsm: handle submodules nested inside subdirs
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
X-List-Received-Date: Mon, 01 Oct 2018 18:26:28 -0000
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The new gitsm fetcher assumed that submodules were living directly in
the 'modules' directory, whereas they can be arbitrarily nested inside
subdirectories.

Solve it by first creating the parent of the destination directory for
the symlink and copy steps.

Signed-off-by: Laurent Bonnans <laurent.bonnans@here.com>
---
 lib/bb/fetch2/gitsm.py | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 0cdc8301..fd5089c0 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -98,12 +98,14 @@ class GitSM(Git):
 
             # Correct the submodule references to the local download version...
             runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_paths[module]}, d, workdir=ud.clonedir)
-            try:
-                os.mkdir(os.path.join(ud.clonedir, 'modules'))
-            except OSError:
-                pass
-            if not os.path.exists(os.path.join(ud.clonedir, 'modules', paths[module])):
-                os.symlink(local_paths[module], os.path.join(ud.clonedir, 'modules', paths[module]))
+
+            symlink_path = os.path.join(ud.clonedir, 'modules', paths[module])
+            if not os.path.exists(symlink_path):
+                try:
+                    os.makedirs(os.path.dirname(symlink_path), exist_ok=True)
+                except OSError:
+                    pass
+                os.symlink(local_paths[module], symlink_path)
 
         return True
 
@@ -148,6 +150,7 @@ class GitSM(Git):
                 if os.path.exists(modpath):
                     target = os.path.dirname(modpath)
 
+                os.makedirs(os.path.dirname(target), exist_ok=True)
                 runfetchcmd("cp -fpLR %s %s" % (srcpath, target), d)
             elif os.path.exists(modpath):
                 # Module already exists, likely unpacked from a shallow mirror clone
-- 
2.19.0


