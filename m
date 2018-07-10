Return-Path: <Rasmus.Villemoes@prevas.se>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0107.outbound.protection.outlook.com [104.47.2.107])
	by mail.openembedded.org (Postfix) with ESMTP id 4864974922
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Jul 2018 17:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=prevasonline.onmicrosoft.com; s=selector1-prevas-se;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=w6B1Kd6LC/y3a0+ANunlCK8ocYVoQyKtOzxOXchCh0U=;
	b=tohzQ7s7VLcqQMgU+9Q7DbsWmJrPyzmj3wgQOFc5kZ/A6/dw8mnXJf5W7a5udNHCka7Fpjjces7wicCgr+IAMnzxkF5TGleAhAIDUCmX1ryD1/jYia3HE2TRHJ5BH2Z9FJJBvZO8w6/B+stMs0byZ0NG3TqWV+/DuByKek6yD4M=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
Received: from prevas-ravi.prevas.se (81.216.59.226) by
	VI1PR1001MB1342.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:e5::11) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.17;
	Tue, 10 Jul 2018 12:03:46 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Jul 2018 14:03:34 +0200
Message-Id: <20180710120334.9609-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [81.216.59.226]
X-ClientProxiedBy: MRXP264CA0038.FRAP264.PROD.OUTLOOK.COM
	(2603:10a6:500:14::26) To VI1PR1001MB1342.EURPRD10.PROD.OUTLOOK.COM
	(2603:10a6:800:e5::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd3c6393-1ec1-4e35-8e2c-08d5e65d3098
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(2017052603328)(7153060)(7193020);
	SRVR:VI1PR1001MB1342; 
X-Microsoft-Exchange-Diagnostics: 1; VI1PR1001MB1342;
	3:xicvWYMcygCu11aISUihaYrGKeZpdamGvHoPpPe0ZYEvNwUJPXAwZk+T6xgj4zLnA5RJb6EAw7sZ7COVOFWnomqWQNghuNrKSQOiBc66uWEmtoxaJxpHVrd3fosd4zLx+Z/VkPz6dixHm/0kiI8NfolnTNALBMWAu2Rf698MKxF9C+rgK7nlxCqchFUkGDHFSTqLrSiWP469Hm2I+XHFLoDuaXeOfDDS8kvB3Uh3yyg86mq1Ab7+OViuRcNsJxMM;
	25:R1JmkrwrabyyggXELRBpC+oitnH63xxhLXUXJROi3ewBlUvDeNIABxoXUJJPW21ytuLxBXV5TIgQqm1uH6lgGx5E3GGmc6Bj6hQljeL2hgGV58UjkPBfkj8SbN2cM/LhdXWNOxdrERmn2TttdwK7MiBzgfdS2odEMbJgbLQNDWgUZIpthAd8BTlCfGafNUk1BI+AjHEvnnj4M2cwk67VWEy8gbgFCe0wT+y74Yhnta/hgfE9XIvRJ3ASfSqgV8fkJ40Rj0mVN6vMrp8PrzmlFqMPg50nqVLNJ7YF8MmnO7ZU7VBvpBXh9DItfD5aRwKXdQqSMdJsbHC+E7sUdgRtHg==;
	31:itc5pvYl85rBdyI9X0robBr8qTRAUV6ok7Id5Z98wrijWZYntq7hD2SgBL3haCkorlY0b4i9pwF49Ah/w8yN6b+h5z3jgfdYV1N2+/lTU7VrLTmys6ojloVBDKvXWGgRChTGG3E2Fgb+w7GRNVLPPz6foLxx/TR0tpbG/46MSBxltfIH5cDh66rZsoh6eb/w3OapH+COBRgZE6eSI7DWD2Ubs3rGGPIUcjh+Z3LHuhU=
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1342:
X-Microsoft-Antispam-PRVS: <VI1PR1001MB1342DF11F5E0942B9A62BE468A5B0@VI1PR1001MB1342.EURPRD10.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);
	SRVR:VI1PR1001MB1342; BCL:0; PCL:0; RULEID:;
	SRVR:VI1PR1001MB1342; 
X-Microsoft-Exchange-Diagnostics: 1; VI1PR1001MB1342;
	4:AWCsErVUYoAYQf7hGwJjokprsqFrd4ogudlOuHDl/ni2BVkeSptiDAljizxxPpyoHyXR0kindtj3RmLarq3k+XJrTNikBOJI/iUjJ6porhe6dfn2i2oCYcGdWAFXY9gYvBiu1lAPObDoWSx/MM0jtFFFk95TuiaWiPuyT8ECueBMSlxdwKLarikCOOHoBJ9bH8qldO6QsRMRzPyU9LrItgkqXLml/duRTC2x+5X3GUk6Ghtyrj+Pkf1oFcY+YLug1mn297CJHu0R7DctaKna/Q==
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10019020)(376002)(39850400004)(366004)(346002)(396003)(136003)(199004)(189003)(6916009)(1857600001)(5660300001)(6666003)(14444005)(105586002)(2351001)(53416004)(956004)(74482002)(2616005)(107886003)(53936002)(69596002)(186003)(16526019)(6512007)(36756003)(316002)(6506007)(386003)(2361001)(50466002)(26005)(106356001)(16586007)(52116002)(51416003)(6486002)(7736002)(50226002)(72206003)(8976002)(8936002)(3846002)(48376002)(486006)(476003)(66066001)(305945005)(6116002)(42882007)(25786009)(1076002)(4326008)(44832011)(97736004)(8676002)(81156014)(68736007)(2906002)(81166006)(478600001)(47776003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR1001MB1342;
	H:prevas-ravi.prevas.se; FPR:; SPF:None; LANG:en;
	PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: prevas.se does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; VI1PR1001MB1342;
	23:QfgNTzdGT8lvgQlozC6bwKi4rvdnFInWfOSRMbt?=
	=?us-ascii?Q?FjsybiNbd4Oj9u3L8BQQ7NQGv2l3nKUDO/LBpJHXW3Qk5q8xlsfLe96zwQhP?=
	=?us-ascii?Q?cTejXbFtl0YIXj5jUCSNxaPwyfukc8CfmSsutYU3QZ9Mwp/bDUt0nnzanLMG?=
	=?us-ascii?Q?irm1f/SdwqNlzRLquOcoxFx6eg6amkq9vJhLGXzvRgqNybYvuR6bHgbVq6wv?=
	=?us-ascii?Q?gir2rrTKJMQzjV+RUQi72P6aQJ9aA2sX7i2q3bRV/ZD7AEUK6GBCfXrEwHGj?=
	=?us-ascii?Q?sl0nVqipY2fdw9NmPDgvSBsIE/peycrr4DrQlsmYsmaaGp276zzpN/b54qRU?=
	=?us-ascii?Q?BpMrh87kvMIs2skYyzgdLBPJjo6Cjownl8Ytr/2hYGLHGFuBkAUhq9zL4FMj?=
	=?us-ascii?Q?nSkXIpjvnhmZu0WL+jMgc/gru3pZKi3FxP1lEfJ26Pr75CNZBXOdwH/UWuXc?=
	=?us-ascii?Q?9wKeF0MqHEj5p/fL1wmDw+xuOoDdSBvzi2tSculLuB9uXkp/+ehF+GJdkLoY?=
	=?us-ascii?Q?PoX9rpPyhowzn4Oe/dwFop1OgTnQEIIh2UvrEokfjdZWbi/Rlh9x5M1YpUMR?=
	=?us-ascii?Q?rSsnqwjE71l9UYwLve9ixLmIeh8PXoY+Oz+8MIoOomx+6ihBlvz04XdPwWyU?=
	=?us-ascii?Q?i5+WWrY77K/xIRWCue9WLS8u47+MGL9UVc3u3+QzDTxlIYtHV8ihl2hwxtn+?=
	=?us-ascii?Q?n/6Pf0kB2b/Wp8JBLihBzKfagrDGuNKOLVWxKhdZ4oTlVo+vlPggs1ifHwgV?=
	=?us-ascii?Q?M8KWlBot4iWT3HtDgOmvIC3BLKEjMM+hf6LXdKxpGpxh4M+LGqQac+I93sCx?=
	=?us-ascii?Q?P/HBgE/yyoFlUBxrkTj1j0uz+HTreZuvpmxFTD3rJ8qJLi3yeGI8EzsIRoCi?=
	=?us-ascii?Q?VG2MIMftv12udGH5gJNVDlQnoYDfey3zjrx4tQm+hcs2LmcYd3WHNd7P6J4v?=
	=?us-ascii?Q?ngAuBKCf+1y7KXFP8uQT3jrLwrOQ6nJoQWwXulaePvmrewdzsGviJyXEI4Sl?=
	=?us-ascii?Q?btTBmBnzPceKAo9T6Y93cw1xRNW8XHzlQurCNFhbLIwMyeji9CmvNQulaWTU?=
	=?us-ascii?Q?S+iPo+x8wl2FNml6XlcpVvnIJqoMFk92+CCmskec0UwE0lUGg7PPBW+LI2Nx?=
	=?us-ascii?Q?YOwJxDoCGqPRgjROAv+TERSbGRffF1S8tzP0oaEFhxYvm7xs8sqLB8d7HWIJ?=
	=?us-ascii?Q?51ucRysRTqcRepHaWXGmnae0pakXlVPlnG1ErrXhBKZiO+5eStBMCT4KXfnE?=
	=?us-ascii?Q?y0SkAv1CG82o3JExiCRmmmpMm3dXEHlz0MCiZypV5UltRNnM8ekvKJJizknf?=
	=?us-ascii?Q?noEb4UWBjYpOSHD1r9uR8/zKltag4cKZTrO1vE6a633GpJ4jskSt4fkJ5abL?=
	=?us-ascii?Q?dmD3gjA=3D=3D?=
X-Microsoft-Antispam-Message-Info: IJBtJWrdnoc8Py7rCNdCoWeD8ZSLqED8bCzEyd6Wurx5fP4Pnnsn8qcSTu6EOqjGKpgFzOdfhRuhFt1Tn14LE6m5TA/CM9XQxpQBM2KnvQuhIXW7PCgGzyESvALtBipqtPuabRJatbsty6ww5hS7TEAV29nnkMP2sBJa6fEnHM4AgAzjOy6iFfcKqKjlYYZj1wOHuH0lxyXlrKa1plJip4Ez0xuCsAKDSvcfyee0607CGx4Epa8grl55j/IAVkVfZHDd6GUWNj0psstQJeqyH+9akiukrHIsf6ck1/HvrZOcdL9AIAoMavMBuDY1GrWUsa/kNZw5OsvLvNMi9RBAbuwFITA/CRg4CJa3eH5VyQA=
X-Microsoft-Exchange-Diagnostics: 1; VI1PR1001MB1342;
	6:pdolISoA5K472XapVVj++dZLyy818dZGy62jPnDeI3KMjVXv0xoVe3fGZHryRxtc/kHFms9AsjAxMVeCWz/zXhAIijjyx87UgidYJ1B/f67jA0BnsEQPHhYF18x5U+HK2eJLqtZ0WBBlEZG0fGli9mRUJmX/zpvSdJfk1Q0ywyyWjhgckNov79pGdu2M+5o+6hS0gB/YgdFn7FezUsyMbGdgIYAfjZBxpMDnQDuS6T2g3Y/ox0sFBpsAScpXHnmC8L3XNrtdyu3MWVbf+2UH6nGs/z3Ww+k11v8BeSQF1nmkDb4ZlErV9KgYiSYDP20T0ZB/yE2qKlgOtEheE3lx4KJZBMwGdeAbiAXNTCA5ULH7tgrzVvcOLrjJMsegOMbSRHF5a9zzwqVzSuwZlOyj4Y6nDH46wUKvdTr0uLI3JiQDPdvsYGGPe0o9U7/8TyrG7KQvlbi9qfdK7hJMKqVuYw==;
	5:GdUKVfY5iMdx0fwV9KqFtEm1+PIkUGUc7SAvRMQY2vSJ5WZuoPA0Yz9pZQJKaXOB449cmZ/fj1lc2jV1qd1Y3nMfrzbqc7M0BNR8pHgzsr+QsOcds46pQeo6s7K+pblpRI2E+aV/F57bG3G805jlpWPJ/c2mvGyuNw7BIEW+YzY=;
	24:pYrBhw0Gmk4Vppr2gkD5sjnGR1tO23YjEx3yHVtJ5Vk7BGqwOGYtVE3Rcf95pxwPKhpYjNwYfWWge7XX7dnIix/fi01S8fgNmIXar+/s6KQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; VI1PR1001MB1342;
	7:m52hexsb8KBDf/ZD4jR421nhui/tYyA0zpvHtW+StoqdcYyJsaiG7P1GjkfxzzFvv1y9r/wGg2UbuXVIC7gedSwNy0rmW6QjIo/5whvwuKFJrYOvcJSNPT/8gnpqxmwg78Z4QISVcFTME8YSLSiAMArtEMSJRDLHiqlxaUrJjyTn2Bb+874bxs+goYt6/n4TFdWHm/dWLyk3+EWvuJh1AD2BJgTYOMsLBB5gZRzMBWpCfNU49pj8TqrC4VtsR+Eq
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 12:03:46.1121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3c6393-1ec1-4e35-8e2c-08d5e65d3098
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1342
Subject: [PATCH] bb/utils.py: add break_hardlinks helper
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
X-List-Received-Date: Tue, 10 Jul 2018 17:37:53 -0000
Content-Type: text/plain

bb.utils.copyfile is called in a few places with identical src and dst
in order to create an st_nlinks==1 version of the file. That that even
works relies on an implementation detail of copyfile (namely, that it
creates a temporary file and then does a rename). Moreover, it's a waste
of time if the file already has st_nlinks==1.

So create a helper that optimizes away the copy in the st_nlinks==1
case. Of course, this helper relies on the same implementation detail,
but that's now contained within bb.utils itself.

To test that we do at least sometimes hit the no-copy path, I tested
locally with

     if sstat[stat.ST_NLINK] == 1:
+        bb.note("Woohoo, 2*%d bytes I/O avoided" % sstat[stat.ST_SIZE])
         return True

(and the obvious places in oe-core patched), and the do_package log files
are indeed filled with woohoo notes.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 lib/bb/utils.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 378e699e..9115b854 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -901,6 +901,23 @@ def copyfile(src, dest, newmtime = None, sstat = None):
         newmtime = sstat[stat.ST_MTIME]
     return newmtime
 
+def break_hardlinks(src, sstat = None):
+    """
+    Ensures src is the only hardlink to this file.  Other hardlinks,
+    if any, are not affected (other than in their st_nlink value, of
+    course).  Returns true on success and false on failure.
+
+    """
+    try:
+        if not sstat:
+            sstat = os.lstat(src)
+    except Exception as e:
+        logger.warning("break_hardlinks: stat of %s failed (%s)" % (src, e))
+        return False
+    if sstat[stat.ST_NLINK] == 1:
+        return True
+    return copyfile(src, src, sstat=sstat)
+
 def which(path, item, direction = 0, history = False, executable=False):
     """
     Locate `item` in the list of paths `path` (colon separated string like $PATH).
-- 
2.16.4


