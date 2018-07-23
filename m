Return-Path: <urs.fassler@bbv.ch>
X-Greylist: delayed 7252 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 23 Jul 2018 18:16:25 UTC
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
	(mail-ve1eur01on0066.outbound.protection.outlook.com [104.47.1.66])
	by mail.openembedded.org (Postfix) with ESMTP id E01FA744DA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Jul 2018 18:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bbvSoftwareServices.onmicrosoft.com; s=selector1-bbv-ch;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=AE2TtZ1MrnHk0DFCttQXr/8TNfRkLmOG9Hs6GSQhoik=;
	b=tSxpXOh+aIwM1dfXCFrxamLT4heYILCgtfvyKAg+r/l8RPeOvMGdPYgf/Sc+E7I7/lDXacqR0fXFwbBTwkqH7VcwrzXN55yZ/p8/WdIIZYRuWo4y7293XeV8m9IPYHJIvZw3QtEP9PRg+0qIp7EzPQcSqy1RIovhBnvx/Yz8LAo=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=urs.fassler@bbv.ch; 
Received: from talon.bbv.intern (83.173.245.202) by
	AM0PR03MB3827.eurprd03.prod.outlook.com (2603:10a6:208:6e::28) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.973.21; Mon, 23 Jul 2018 15:43:26 +0000
From: =?UTF-8?q?Urs=20F=C3=A4ssler?= <urs.fassler@bbv.ch>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 23 Jul 2018 17:42:50 +0200
Message-Id: <20180723154259.9076-1-urs.fassler@bbv.ch>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
X-Originating-IP: [83.173.245.202]
X-ClientProxiedBy: CWLP265CA0143.GBRP265.PROD.OUTLOOK.COM
	(2603:10a6:401:53::35) To AM0PR03MB3827.eurprd03.prod.outlook.com
	(2603:10a6:208:6e::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f3b1250-6a0e-497b-409d-08d5f0b307ca
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);
	SRVR:AM0PR03MB3827; 
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	3:fsjAFpMUSSjhgwOSdNaCFOQgkWshbcRyvQyPgRfr+s6uMvt/5/Ko3GCEnYf4owkV1la2zcAr3CKaCk12+mAszVcD93DuyuFxZooeEQ8NVmPK38aB1+9T1NOIoBLRUU2P86EAT0/9IaWS6HjhhLwEokynJwYsbqIlnR7BEntaJiZyvepKOa0JmgwLDMW8xf7DBS0qMJY+0RlsxwGhf3f7Wjjz/sEYRTYgaZo6xBFkjYTiTErzzbWXbJIHxSSS7H5O;
	25:2ThqEyB4UX5o3wO5sXNp6YKT3oBPfaiL/LKbFt//zjt+vRmWK73nn1HCAgKGqFc8kg4QfJdr/eZdl/n5L31uvZO4jOzV3/9/YEIG0B1m/m13TKVgoUfQShUHEidbkoHvNO8NKhYirziLG5fZql1E9SIYS7B0PyDirGPhw/E6AcQ6KqkBTikcn5mXSKihtYoRM8IYP98FxbiLYKxohCfmCg1qj4uB5hInH7ZgQZ8CbW+JDS2OArn44EcycnsapXvhDo/xYUmAiphfbUKPb4UPutF3KPwksBsZetS7XPMREC0O2SqVGxMWVFOE8XtKuHrXa0pMoZvg434dx5YADzvp/A==;
	31:tfPeIWTD/W9uM5MTyhapgTfyFpxTPkkiv65u7i0r1FaCVS01TZvjh2E7o8aMuh1aN70vld9VAa8+FuSqxrYQbd/0epBVyJipMkXYO5hgYXYypFxDJkJGitLnWD8txKJU9ZoJq4YR+OU9dvEje84OBeYxD9KOGUeX7zMRyJZ0uBFOjgPPCtul/d7lG2Yf3ApnoVvzNxqi+xTHoyRKErEvUe53OZDE3FeSmeUayrhr4Z4=
X-MS-TrafficTypeDiagnostic: AM0PR03MB3827:
X-Microsoft-Antispam-PRVS: <AM0PR03MB3827C32C69882C5D4AA3BB748F560@AM0PR03MB3827.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);
	SRVR:AM0PR03MB3827; BCL:0; PCL:0; RULEID:; SRVR:AM0PR03MB3827; 
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	4:9pRI3pF5WqaNsLugExssSX9+oN6uv8RgBotwiOIoGWmX0NN7l1M5R3vKqDMm2jwAYv9lW5iDrA8bLJL0dAynTmosRB+buB5ZEMvKomwhKsjZ9U8BfcWRQj8Y6TPtUEaaPbUVYTOLQOV6Roewer/ru2RiPWS00ryX0dk75XE1Aa9e3gYeDQ8kaJrbyP4GREY0m+sD6f+RhejRN23wW0jl6IQ5fBEfXM7s40aHQAGUvDHY5xB7EcIlVJtWypVUh3Ib74D+bxR7jDCy4bV7lTC8G+ftpHqVt01sKk+0uPIguYGFxFBivGku5Fo3lUH/BY4q
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10009020)(396003)(376002)(346002)(39840400004)(366004)(136003)(199004)(189003)(68736007)(956004)(2616005)(50226002)(6486002)(86362001)(316002)(5660300001)(476003)(486006)(305945005)(2906002)(6666003)(6916009)(50466002)(8676002)(8936002)(2870700001)(52116002)(81156014)(23676004)(7736002)(81166006)(4743002)(16526019)(186003)(14444005)(26005)(386003)(6512007)(6506007)(3846002)(6116002)(74482002)(478600001)(97736004)(53936002)(4326008)(36756003)(1076002)(47776003)(2351001)(66066001)(106356001)(105586002)(33896004)(25786009)(2361001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR03MB3827; H:talon.bbv.intern;
	FPR:; SPF:None; LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bbv.ch does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjAzTUIzODI3OzIzOjhqTCt1SXlJcVFFNFlsMzMxZENadDRUWmEv?=
	=?utf-8?B?WjdYUHdXMkVaQi8yV1U4R2NSSzVNOGxNYzZocjZ0UlhWK3RzN0Q2SWR5a21H?=
	=?utf-8?B?L3l1UkdyQkpTTWRqS2hmWjlQRmlwblAzSTgwemgwdE40aFUxNVVUZnlhOENt?=
	=?utf-8?B?cnVVRVJZUGdjaTNDSS95SndPcGc5QnN1cC9Kdm0yWHgyRnVERmxJNHpNTnZY?=
	=?utf-8?B?dEkyLytKVVJsVWFJRXRpdUZkdFpmWDlEbWNwMC9YL0FzMTczVjYxbzNUTE1i?=
	=?utf-8?B?WFpZNDhXWkU3dVpMVXFQdE9TWGlMMVY3dDI2MmUycUltRFBzcXlGT0FZUTdE?=
	=?utf-8?B?Rzl4NjJJaXU3VEhOakcvN2c2RDM4a0thWjhHQ2UvWE8yNUlLWXhrbXRFaGhS?=
	=?utf-8?B?QXltcFFaeVlTcVF5bklhNTNkblVlRjM3UHh5Nno1S1dkYmI0d0c5djFMdEJF?=
	=?utf-8?B?ZU9JeDViTDF1SmJUT1lZV3hpd0VaK0k0N3I1czBLUktITmVGRDZ0NHNVanN3?=
	=?utf-8?B?alVYL2tHUXNtMjRsaHo2M3VHV3dXS0h5dElZNXJ0Q2puRGhPT2FzeTNHUVkz?=
	=?utf-8?B?NVcrK1BVdndaOVJ2dm1qVVZIWTEyVU1WMVJGcDB0cjRtY3NabWNJQWhVWUYr?=
	=?utf-8?B?czZMTkRyckJ5OVRvRDNyVC9rQjV0d0ZBUTR0aDgwNWgzZldDeG1JbitsVjBk?=
	=?utf-8?B?dGNjNi9HUXBLekUvQ0EzWEJRcE9leW5ReW9qVmVadktTOVFlWTlZWmMxTGMy?=
	=?utf-8?B?c0phdm5JSE52QS9DNHBTd1pDSUpvSEtvYzVJWTd0a0R5M0k3RHZOdFJNUFM3?=
	=?utf-8?B?R0VzZ0hvN2pBcjhVQ2Q0RmhqSStuaXJ5RldrRFZEeE54OVBSU1lNQ3c4R1hq?=
	=?utf-8?B?NXF3QWNnakNlWUpQeks4UEZLTGdmc1lwN2pvQ2d2VEQ5UHhPMy9SdjBJbTB2?=
	=?utf-8?B?SXlXaFdTUE1OaE02ZmI0SXJCcTRnWk5idmh6UWtyQ1hVYlRnL3hxVmJIMzRZ?=
	=?utf-8?B?ckFWUjgya0FPWFNkWkVKVzROeE92RTl2L0EyQ292M255SzBudXZHYjJ4cmpW?=
	=?utf-8?B?bmNvKzd0L0p6ckQ3ckVGUE90MEhRQ1JFczhJeGViTTF1dEE5RzBFbmV4eWo3?=
	=?utf-8?B?TnRJaXdNYlVHUGJuM1YzWGVwaFZiZUVFQ0VYdS9RcVVtVEdXUGtubWxWZmJJ?=
	=?utf-8?B?a3pybVdJbDB6aHhoN1NWUXJrTk1EUXRZRENHWURxMzVQOFdxcjVpNkRSbVBU?=
	=?utf-8?B?N0dDdW80aXowTHhDMnRoTUtsa2lYek00b3pJOFpGbzVCaVRuTkxNZVE1aldP?=
	=?utf-8?B?di84UDU3aWJXdjFtdWNyWTFaWHFRZW13QlhIcE5HU09qdXU1SEdEbkVoZUFl?=
	=?utf-8?B?aEk1aktQZ0V5U1NnWjliNTk3cW56R1RVRW9CNWhpYXZiZXRwWW4zUnF1aGdo?=
	=?utf-8?B?QTN1RlNsK05zQldWekxUSU9PMDJtems4eFhTU2tOSnBoenhSN0puRVpvZElU?=
	=?utf-8?B?NTFQd2gwQ3Y5NFhjTEsyZ1JySmluNnhLcURZYmNYRGo1bjR5ejBYdnJBcUxK?=
	=?utf-8?B?N1VEZDJwL0ZXbHdDaWxYREFxSm5VZCtjWklMTTV3NCt3YlNoQjMwTVJHU0FR?=
	=?utf-8?B?aWpKSXNseTFGTGZPM2tRSnB5MkdDQkhNVXFlaDU4a3FXcnZUNG12Y093PT0=?=
X-Microsoft-Antispam-Message-Info: k6Wqyx2KFXQoy7Fj03YjS2+pWKviEkQ9rc7ITbXLlKcTvQNJYjXApEDvXpaUsm7eViFCXIXMIw1qgLr+8wyWbd+24CKss8hvGxTZo/wMKIksSqWIqBovrz+sJTs4HmN7/j2mxvUlmWLcHodEWaDBRQnqt/ccpB6NLwgdDklmC+yI2BYMt6T/UMbYF2HHsHSESR3ByJUArYjyt0CO0yLZo914bcqBETGhoIou5jNCnePZFhIFhdu+byW8CQFMAv9DJkzFSGtuqzqxjcLwOLbjSEKKVWuRCtMX/0HjDtv8aqbdB8pYoxXYHzXgKh5+zrMTksuLuTXib5txoeu3fh7F2TXGQNhPLvRpfACTzQOn13Y=
X-Microsoft-Exchange-Diagnostics: 1; AM0PR03MB3827;
	6:ErhWjMFkSpItAcEzVn0fRY7065P6+R5rzVdFlbeW2K/I0tNSO+OvhMFNS8KS2imJNGMtxWD44rDAf74DifYZkOyiTMMZ3TAzKk2rmvKHH5bJv/jBUMBXgjciLDu0sREjL5IlqYFQ2u9ptZf/9PAUE3IZoEn10dV33DQiPYzlRxRhJU8aPgIfVaGj1tBpcR2udzy8XuIrbx4dyIQyP3XxyEfpVa1pmHtDS1ak1r4FPlOA3VuP4wJ+WWjJdYbWBilNPlGJy2eM7I3slnQCsZChtdxu7KJgqiIYNB0QwEd+kdE65PgHf57AnVgDIckXJIdLFfqqeDZVHYTMtHva6FUVMxXHKLK6eANBhCl2ICxgRLnM3c3+3o9xpAVJaOnJCmI11JJH1a2vGniLQFZBdFJmkZ5I+WW7c7DxeYLvyZe0PnVMeBE2ePXNzrYtrMJH2sw6sLm+g7bC2mr7i/cl9Z2t/A==;
	5:TCWbrIogR164oyOaV0e2vZEnPeHArOXn+OUk7gTXFfonN+aWXknXCGz1JJ3TPj1mU/jBkJZSx53GFAjGZMOooGzNFCnCgukJocJibEzTkauP2oBRlZKI7LWh2aCVAL3Nrho4/+L5THbSjMsB/ResaX2NeJFrZhB5tCE0DYj+BjY=;
	7:XLHtoKFrD68/ZulZxdv7TkFC9zzQyjLT2s+oY5cyRrj6N2Y2HucG86b4Tp9S3Lnj5SzoRY3sIiNbqdwZJ+aKfWsRnNhCQuoSSy1Rd7+vtoW1CIkiLjh3xa0Mdz1DnSYkn6F9j1xkmsY+gT5DhHng8duStF3XmycyoA4QVwxREVVDPyOQn2TJHNmKD+ZJAnYKHw2f29jRboaLNXTuNiqzbz70ZF03qAO2FeSS4y95zwRnIVMULgOBPdrdfni04rrQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: bbv.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 15:43:26.1582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3b1250-6a0e-497b-409d-08d5f0b307ca
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 279985bd-2077-4d9d-9797-42238cfc06e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB3827
Subject: [PATCH 0/9] Always use the url specified in the recipe as a base for the git shallow tarball naming
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
X-List-Received-Date: Mon, 23 Jul 2018 18:16:26 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The existing behavior was to use the url where the repository was cloned from.
It happened that the tarball was not found when a mirror rewrite rule was
active.

We now use the url specified in the recipe to name the shallow tarball. It fixes
that the tarball is not found under certain conditions. In addition, the naming
is independent of network/server failure and the mapping of the name is easier
to understand.

Urs Fässler (9):
  fetch2/git: add tests to verify naming of download directories
  fetch2/git: add tests to capture existing behavior wrt. naming of git
    shallow tarball
  fetch2/git: only use relevant checks for shallow tarball unpack
  tests/data: extract LogRecord into own file
  fetch2/git: throw error when no up to date sources were found during
    unpack
  fetch2: declare urldata_init in base class
  fetch2: provide original url in addition to the mirrored url to
    FetchData.__init__ and FetchMethod.urldata_init
  fetch2/git: move generation of git source name into own method
  fetch2/git: name the shallow tarball according to the url specified in
    the recipe rather than the mirrored url

 lib/bb/fetch2/__init__.py  |  17 +++--
 lib/bb/fetch2/bzr.py       |   2 +-
 lib/bb/fetch2/clearcase.py |   2 +-
 lib/bb/fetch2/cvs.py       |   2 +-
 lib/bb/fetch2/git.py       |  56 +++++++++------
 lib/bb/fetch2/gitannex.py  |   4 +-
 lib/bb/fetch2/hg.py        |   2 +-
 lib/bb/fetch2/local.py     |   2 +-
 lib/bb/fetch2/npm.py       |   2 +-
 lib/bb/fetch2/osc.py       |   2 +-
 lib/bb/fetch2/perforce.py  |   2 +-
 lib/bb/fetch2/repo.py      |   2 +-
 lib/bb/fetch2/s3.py        |   2 +-
 lib/bb/fetch2/sftp.py      |   2 +-
 lib/bb/fetch2/ssh.py       |   2 +-
 lib/bb/fetch2/svn.py       |   2 +-
 lib/bb/fetch2/wget.py      |   2 +-
 lib/bb/tests/data.py       |  25 +------
 lib/bb/tests/fetch.py      | 142 +++++++++++++++++++++++++++++++++++++
 lib/bb/tests/logrecord.py  |  51 +++++++++++++
 20 files changed, 258 insertions(+), 65 deletions(-)
 create mode 100644 lib/bb/tests/logrecord.py

-- 
2.18.0


