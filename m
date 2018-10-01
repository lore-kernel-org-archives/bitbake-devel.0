Return-Path: <laurent.bonnans@here.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0095.outbound.protection.outlook.com [104.47.2.95])
	by mail.openembedded.org (Postfix) with ESMTP id 164B678A96
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  1 Oct 2018 18:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmcs.onmicrosoft.com; 
	s=selector1-here-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=SiRGlDB7z0kKFRDcuThBkPJ/vm+15jSUw+pAhirIZlk=;
	b=P5RTEJ9tS0A+saJtse/7oo64opQ3gVHsY4re0IGS8XCTok7rFtD4HXulmmA275dVFWbu6hHiBqJK0Jy7VcMejg5565kFwQQpsrGY5xM9Y2gSwiKONJEXnsB4mAeLOV7BP6RZK3dopxOT6PgIcHRl6ND6BYQ/oN3lmw2kIoJCcJ0=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=laurent.bonnans@here.com; 
Received: from herelb.internal.advancedtelematic.com (87.191.159.149) by
	AM5PR04MB3283.eurprd04.prod.outlook.com (2603:10a6:206:d::26) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1185.22; Mon, 1 Oct 2018 14:52:34 +0000
From: Laurent Bonnans <laurent.bonnans@here.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  1 Oct 2018 16:52:12 +0200
Message-Id: <20181001145214.19329-1-laurent.bonnans@here.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
X-Originating-IP: [87.191.159.149]
X-ClientProxiedBy: HE1PR09CA0080.eurprd09.prod.outlook.com
	(2603:10a6:7:3d::24) To AM5PR04MB3283.eurprd04.prod.outlook.com
	(2603:10a6:206:d::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d0cd215-e75b-48ca-cf6f-08d627ad85a8
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
	SRVR:AM5PR04MB3283; 
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB3283;
	3:XOy6Vyq64/BQUY5Pft3kgxauipWifPDO/u7vxKjqANkeABCe6ln86fWFUNEkB5L8vJ8UcjNRaRnk0PnYUhPsY5UXlGZ2KBTrGvXD2pC8X54w1BBntk3LKjxp3w0avDYSMiAzaqGM5c4EmE9gHqtQYzK8dCkyQPQqVocNeeX7ak1PsrmXEzSBN8JWy44R6XO6MQ4bM5C+Zafqr0IdmP79MDCOs1z0HM06EdWyRqQ9BdS6yD556/IsftfgGv5qpfXP;
	25:GFnfDftn5QOJhgbKt0f8gfOg7vZvAqABYFVv3lOBuEXsZ7jmMGOMKn7rNO0QOhYoszC9WF4IO7YBA0GOKOqIMFJ9U1h5Tc3QIZ/8EC4JYS6ZHZwx8FMdYLjUJeOPBh/vgr/BGjKe+FcEXL3+VGSWEisEIT5i9DL4Yjpew97ja/ycQ4GS/suRXAxQHtyn4pPaa8V4bq2Ebokj13cnhXVMWsHRCAZCXIf6ECbs3YpxeUDhTrHU5osKihpdQL4GQL73AQ56QZQF489hFIiC3/903E/AH/oD7VUi8qqWdtu6w7/Kmh0ELQN/ymKH0LOoqsEjU7+MQFKyJ+0Wa/63LXa1BQ==;
	31:FkUEcDaf/FuBqVDVeGIf33iffFHZYS42gweiKYB3cYOeN7mbVoLv8/8jH/2SRigLe0pVI1hxAaw9uzOCwvfuHLO3vP2nIm1QK+GbH363a51U1EiQr04PmymKloybIFxQqOiPF/+3SxO2wY/Iw2AGIBuH0LHMjpzzl16KNqebtmJ5NFSAmRewTXegzNAoYmCz+nOTT+yC8oiBtgX10P//JO2Gttth0x7ZYFroFDIM13c=
X-MS-TrafficTypeDiagnostic: AM5PR04MB3283:
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB3283;
	20:gI+tUGS8XHGIJSVE5r2O3grbZxNXJUYQWFvXz3LLDqOnCSFMxL4M/mYvqluwa6C1/akSpQ82QQ9IkR8cuVX6d0Ps3g0H4y+Fuk6I9xq3dIoY2fxw/9yy2bMtaSiKhPehhWOv1fT8JD24IZJTYTAkxVhVgVdU+DvNs2KXdAna+m8Bb2r8vKZj1ve0+sPOxzgQYceJThpYpcziIJCBCkSBNXx6DNNSCeFkQcLCUSOITSoSvwfblQu2qZmU2pMPE59Kv9MKWisUQTkXdXDASxMnS9nXpVGg3BY1UDIJhkMlQxrA4uktXRTqnsJ94D5Lw7hT53DZgEwUam1al6ENYEvEPiOaNqJRod7B9lGcVtQ92Q8S53OmnpCoInQDPEN6Ui+yRQ8cUHiY+nvIDSqJV/7I1csXjxuXwOsDTJWTg9S37WewsQgvEpHyLfRoahcsOkKUwSs3fQKHU9rYiScJgCdKsTsbUrD+Md5TdtjcG8M8SU8SzahX68qIYLrUxs6g9xow;
	4:b001suioAPWg0g2CCZkKkAjE0VgXJD9lyewEUTA63XSCZAH+TGnsM8jGBzh/ydMcLEcNAy98zbVUvIVRqgp8KKDiAEfP1gOpT8pcTZPmT4qy8BN6m+1cBiZu4ro7hpumOrw2GQ+bKhGIcx6vfrB80IMX/G6/Rg1+NBm2CByzqynTTazKe4c4wP4oFWXPT90TZpNl7NOVNIr7/mOWNbrL24PH4XuiLneDtELg61by5VZPWgd13xD5N4Jikt8qxzdYvK5O8FHxpgysJAG046SXsja/bBUc+8MDhyH99S7V2p1S4dfvXYcKV5S3TJ3HZKPHs1lHcm3H+OUymwIyt1cYgQ==
X-Microsoft-Antispam-PRVS: <AM5PR04MB3283F8E389E4CFD0F455F05485EF0@AM5PR04MB3283.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(87047540314649)(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);
	SRVR:AM5PR04MB3283; BCL:0; PCL:0; RULEID:; SRVR:AM5PR04MB3283; 
X-Forefront-PRVS: 0812095267
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10019020)(39860400002)(396003)(366004)(346002)(136003)(376002)(199004)(189003)(7736002)(2870700001)(52116002)(575784001)(86362001)(68736007)(2361001)(486006)(2906002)(6116002)(3846002)(6506007)(386003)(51416003)(50466002)(48376002)(105586002)(106356001)(6512007)(2616005)(6916009)(66066001)(1076002)(956004)(47776003)(44832011)(5660300001)(476003)(2351001)(316002)(34290500001)(107886003)(53936002)(25786009)(6486002)(305945005)(186003)(26005)(97736004)(50226002)(81156014)(81166006)(16526019)(4326008)(478600001)(8936002)(8676002)(14444005)(36756003)(6666003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM5PR04MB3283;
	H:herelb.internal.advancedtelematic.com; FPR:; SPF:None; LANG:en;
	PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: here.com does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM5PR04MB3283;
	23:Sq3cWVrgoOl/j++5W+MmBAtlXzmaazEiXRoDVQpGR?=
	=?us-ascii?Q?ThDM686zrz5uXN1Q5B+n6IjOxd9WrnLE9GqyJXKLAOlA5HOnf+y3IJ8tjCZW?=
	=?us-ascii?Q?PErPOrK2+kKKOab4HLZrHimdOmXuC5aRZypKCZXiFJk1dFfSKod1lKtT/aWP?=
	=?us-ascii?Q?Ny4FneaCJDT80pe+AkRxthQWW3T2AFkgzG0I/PKeSNgIhy59FE7I+0dxbp8B?=
	=?us-ascii?Q?9nenTg8V++tGQcl73nbL3fkw0Cc4VoVNF8nvTzetNYivPkYpTOiBh692DG5/?=
	=?us-ascii?Q?jSWruCUnVfecaZkGYljMyiNheTMUb/BOZJLFkzQQLcmULAhd+n4zOAyHVQQT?=
	=?us-ascii?Q?KL6pY40xaTlHyp00hsmOY6VLXibpar/ilhjQkleRGCTRG1MQe4gMIDUkcr6X?=
	=?us-ascii?Q?Sjj1Cxv1cb6gDPYOhbK43JPrdEZngwKP+9xVYWR75obpOuiktZvayyKo/m1d?=
	=?us-ascii?Q?omkqtb9NbuyUyxDJ8GDVznVQm4YSC/kw82C/5f4nciI/hn5NRmOtF+GiF4VU?=
	=?us-ascii?Q?2Wcs0HH5+xdwxp6wgfJmcujoRyixZCBwB+8GPD1ZtWYebaPGhSIGpb0qnvlK?=
	=?us-ascii?Q?0hHSjzwRYxUpzv+xDuQDuuZsoHa4rwRhtmcEq6Myl7YsG/cqbieYsMFCu+Bm?=
	=?us-ascii?Q?lQ+jArseAIVjFsmbnpMscO7eORkDLT8sG6YCWLpNT2xKEEq7xXrkDl9XzZDM?=
	=?us-ascii?Q?RTKL4NvkVr2Jb29RPp1v09KVT85WZoluypkVHSG4uEFkTKnLZ7OWtk1mbvxv?=
	=?us-ascii?Q?c7ZD9kb3xVaAdCGOpQ3iUIBB1n+0+x8pePIBz8kiNPr8nH0MQlPSr20evDqJ?=
	=?us-ascii?Q?T0SrvSHkUJ6BulVjXaNz9ix9neyOxrI2aM+YbKmV3W2o5cCPdtpMK2LKQG45?=
	=?us-ascii?Q?m9HKLZfKUqJ+YDZdRz+3zqf98EJ54cDxzdi76ue96vlBgZsN1a+v6Z/rHfZ8?=
	=?us-ascii?Q?RdsxhXfxizQK1YnyCJ/V0ggdkl5KOpAzyw5beZq5g/7WoW4BM1mAfaTlWe4j?=
	=?us-ascii?Q?pW63KUK8AdTFj0kfgXIWzkxamSULhKrvQyRIKFKgnppmSfwYmIKCYF1QtL1v?=
	=?us-ascii?Q?9Tg3FTquic4hGdtnD9eJPXFD7nG6M84h8Q+hVG5g1DaD4mvwA54WIIqpyLB4?=
	=?us-ascii?Q?3Cabx/cdAbjMsNbfgv5J/Ux0Nw0UlXX+y+pWP85wG3cJqAyxQHCGrwhzhXQs?=
	=?us-ascii?Q?9jq+wqn3M1zWOXvtF8PKeEysF5IdoCzRxo2IqMNqLf7j/326/6PnNEpVabwH?=
	=?us-ascii?Q?ncD3r6r3N5YL2vkvtEstR5Nem49F8PiJf6iIjNjHNgNGrnX/ikqmV1wg/cVR?=
	=?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: La5x7K+ZpaiML4jU3+IFF9mSwwvDrncTL14LnMGfPhEvmEmwppHOLRlkY/Ktdiepk6yYdEsBg/l7wshtXzDLOiYaSe1IO7KBCAk0VDIvNREISqbogiok3T6r7XXfA/HMASTxWgbXNVB7rBUcRDMUeL3ZN/GkS5p5MnETSDnqS30QfWayidT/+4aP8vMKWJaRYjMxI5/7jJCTm1oBFSlOZUrkY31/hd+0S2TzWq+bs4Fek+g68woX1MBJKOunmK6LqHm97nuuFefrtqNuWF8kOIFrBteRHtq5zd95x7fmOHu1QJzB84MZoUQK1siz4N5KiQlovIsuKzp/eD+xwtu/iN6Uf9WtWpbvAPrImAH/1j8=
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB3283;
	6:vKnIMWNXSFCd8TDL8IkxZd5Y1t5sGnqd2Kof0omHcZfiA7NTlydhQYgK3V0oksUjlunTIgerkgEVyO8/jQILjNdpjhH/USlRt/JyCLFg0eEdUn29wCABlFE2GBKMm65UdAuZ/mOaMTa6jFJ2d7ZsIx6i6z+Cqxa3rKVjbYfphGywEE7UnR3bC3OYbNAnX2CcEZizdyS6oNsGEnKkufWL59W+EcVhmtb8xfq3dHlxX0iOdezz0u6GLIq73Qd2EAa560XtYBuBSHPOtf5zd7hlLHo9x/rgWrkGqKi16CYdgtzqp+okaCx7YAyfYBiXKg2OcgG7I9D5D5qNiKFCXasMxX3wpHojBd88QWuDQVtMdLywkFhUaArGaCNugjlRYBQOk6eWTTVsrxTdOgIdOyYBDW6FEiO5a4JHbc0OiTz/lQqxH/Gx5a8lq7oEfgDDjQtwxSqH4grd6m39UahjuKTP3A==;
	5:i46VfhYqFWU4q84wgotM9bF8VuFU735HXR0SsaWpMyxJ0f9QRebhgcoYvXPsPuRodBjAc3Z6P82HMl7g5knU4Y51WUy+kSoTMZpBi7n0WPzmIdo5HHuPrwFAZ75xvxTJWTDMkcM8KbTD0ygke8CobtCv2TO51ayfFN9u9Iab+Ho=;
	7:d2GpP30aAlm30vK1Fsk9lvnD3mReD3G2CKXfO/vPJo5aBNwBYGzAReZYYLX+w/KFyo88PVp0LaFAP1oOUDQePYlI5eiIRVg3Pzj2emMYI9/ku4Z+h9hLKhhNRHSt7Wrqx7Wt30mPsUCw/1QS/POZBlzsbGgEnYseSUDW7rtSYh/LURn52GyA4DCnBnhMd8c2OdnwQxi104ETKT3f7zLVr02/pmYi3QbRFsdMNO0o226iFvuIsuUaxCvtsZcZbC9l
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: here.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2018 14:52:34.1549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0cd215-e75b-48ca-cf6f-08d627ad85a8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d4034cd-7225-4f72-b853-91feaea64919
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3283
Subject: [PATCH 1/3] fetch2/gitsm: fix a typo
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
X-List-Received-Date: Mon, 01 Oct 2018 18:26:06 -0000
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

'qbareclone' in place of 'bareclone'

Signed-off-by: Laurent Bonnans <laurent.bonnans@here.com>
---
 lib/bb/fetch2/gitsm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 51f8d0e6..0cdc8301 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -78,7 +78,7 @@ class GitSM(Git):
             url = uris[module].replace('%s:' % proto, 'gitsm:', 1)
             url += ';protocol=%s' % proto
             url += ";name=%s" % module
-            url += ";qbareclone=1;nocheckout=1"
+            url += ";bareclone=1;nocheckout=1"
 
             ld = d.createCopy()
             # Not necessary to set SRC_URI, since we're passing the URI to
-- 
2.19.0


