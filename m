Return-Path: <BSREEKAN@xilinx.com>
X-Greylist: delayed 5583 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 20 Mar 2018 22:13:22 UTC
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
	(mail-by2nam03on0087.outbound.protection.outlook.com [104.47.42.87])
	by mail.openembedded.org (Postfix) with ESMTP id 76804788C2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Mar 2018 22:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
	bh=fGNL9pNz3C0yma5h4v1j4RmTnEBOkpR149ljV1N3OAU=;
	b=QiPDUBHHEn7O1Zn8HKds85sKRrlNs4/yENTQ7FgiwIyBVdDWynWmx6jfshnbo8+sWj5tHoqx1AK22PTf1hT8E+TGBwLqNdKkLq91SXT3gJfOkr4VIZbyOJa8EfA+TIX2MrXESZyaecBXkcnt71SrjFUyqEDBcBSvBlIb5WhyiHw=
Received: from MWHPR02CA0012.namprd02.prod.outlook.com (2603:10b6:300:4b::22)
	by SN1PR02MB1310.namprd02.prod.outlook.com (2a01:111:e400:583e::12)
	with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.588.14;
	Tue, 20 Mar 2018 20:40:20 +0000
Received: from BL2NAM02FT046.eop-nam02.prod.protection.outlook.com
	(2a01:111:f400:7e46::204) by MWHPR02CA0012.outlook.office365.com
	(2603:10b6:300:4b::22) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.588.14 via
	Frontend Transport; Tue, 20 Mar 2018 20:40:19 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
	smtp.mailfrom=xilinx.com; lists.openembedded.org; dkim=none (message not
	signed) header.d=none; lists.openembedded.org;
	dmarc=bestguesspass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
	149.199.60.100 as permitted sender) receiver=protection.outlook.com;
	client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
	BL2NAM02FT046.mail.protection.outlook.com (10.152.76.118) with
	Microsoft SMTP Server (version=TLS1_0,
	cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.567.18
	via Frontend Transport; Tue, 20 Mar 2018 20:40:18 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:58181
	helo=xsj-pvapsmtp01) by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
	(envelope-from <bhargava.sreekantappa-gayathri@xilinx.com>)
	id 1eyO3O-0007XU-He; Tue, 20 Mar 2018 13:40:18 -0700
Received: from [127.0.0.1] (helo=localhost)
	by xsj-pvapsmtp01 with smtp (Exim 4.63)
	(envelope-from <bhargava.sreekantappa-gayathri@xilinx.com>)
	id 1eyO3J-0008Ph-Ec; Tue, 20 Mar 2018 13:40:13 -0700
Received: from [172.19.3.10] (helo=xsjbsreekan50.xilinx.com)
	by xsj-pvapsmtp01 with esmtp (Exim 4.63)
	(envelope-from <bhargava.sreekantappa-gayathri@xilinx.com>)
	id 1eyO3F-0008Mg-Hi; Tue, 20 Mar 2018 13:40:09 -0700
From: Bhargava Sreekantappa Gayathri
	<bhargava.sreekantappa-gayathri@xilinx.com>
To: <bitbake-devel@lists.openembedded.org>, <manjukum@xilinx.com>
Date: Tue, 20 Mar 2018 13:40:08 -0700
Message-ID: <1521578408-15225-1-git-send-email-bhargava.sreekantappa-gayathri@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(39860400002)(376002)(346002)(39380400002)(396003)(2980300002)(438002)(199004)(189003)(36386004)(8936002)(81156014)(106002)(81166006)(8746002)(8676002)(47776003)(54906003)(110136005)(63266004)(5660300001)(9786002)(7696005)(51416003)(50226002)(4326008)(59450400001)(36756003)(50466002)(48376002)(1857600001)(2906002)(186003)(107886003)(106466001)(6636002)(336012)(77096007)(478600001)(5890100001)(305945005)(356003)(316002)(426003)(72206003)(26005)(107986001)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR02MB1310; H:xsj-pvapsmtpgw02;
	FPR:; SPF:Pass; PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;
	A:1; MX:1; LANG:en; 
X-Microsoft-Exchange-Diagnostics: 1; BL2NAM02FT046;
	1:BYGqLpFBKV4tJATeaMLSK/9aq2EDWK+l7K4VSqAQpnFqvN598UqLysT/HeqLYT7MKO9qG6n0+p3LuPOeFDVfinuiZOyDvGs7zLjnbejqpu51m+dRP9af5irrLtGQND9g
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf9f242d-9f4e-4c95-fdb5-08d58ea2cb65
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);
	SRVR:SN1PR02MB1310; 
X-Microsoft-Exchange-Diagnostics: 1; SN1PR02MB1310;
	3:Y+yj2ACb5IB+letitgviBSwmdkwvNfbLeKFLeHPZwaOBxbXZYfK/nhBQqtHmPLDKjVENd7ibIWffHj/BUipC3pzrQwv+NCkkNMazQSJcJpVvq3/iSH5EFWjRRA6HNxkssf5G0/8S6nRWCdMiD6gj1ax8ITQrP5mynDKJKT1DI3+t89NdWU0a2AnsXItIr26+5AMcAQv32foZnUdKr9zyxnNiLfyMfi6nOgME883EPPhilWVtgpy9XUTQp5V9wkEyRfnPYRgtiMCxEz7k/j7yXJTdLdlVza8xBTXXbqV0ZPB8ONHxETPVX6esvx7LyAN2useq7Lp95q8AqvBLZ9Z0PBh7jGiYFUFhH24bATOFrnI=;
	25:BVCTvkv+6DxUy1/eKtGm9hZMJ0qvirjiprpNdBPB33fPOI+GwOllbz9lSW61J/Y1ts259sciY81XGl7fIjlmJSouDY6kEgeXJZ+8Ub3jir1JVU/EUHpholoT7YSto1lzOdomLbLNYRR1Yqbu95FQL9eT4eStJlD9bPWg57ANNGBdT8Rx38lT/WooVWExM3JcwzYrss/0wzv2Pyyk5tMkLQX9x/OACTKkpQS6enpbp7ZhA9WF1B8kvNxPZzOvaj/apEioTceGIJAPZVaK2xG+LS9sTmoXdP9K6dsGpGtTK1VK12pXkvymWeJsDiNd3I5I82NZvcgViqXFqmFGGqGwwQ==
X-MS-TrafficTypeDiagnostic: SN1PR02MB1310:
X-Microsoft-Exchange-Diagnostics: 1; SN1PR02MB1310;
	31:8WZjqhQNqZr6S/Uj6WaSoSRF/jMcoMn17rqjJf6ZFb5K6FRXxfZAhyCz4CgzVHvCYjftU5x9vF4V/77HsT2PxltcQ13WpUoyB036w5BzPJzwuZ7dBmXCqLgfurpe/ZMQf6CNcRtyZDx5BvjIMD8AvGVzSkL8utJp+kxFNMJOutJOmw+BFOepSQM8T7fj6LOijS1Bi98ug9XhEFp+fMMdDoY21Kv9+Jj/e6C/WDups2E=;
	20:RxxMmyljx4AXO4KDnSva8W+7mWZaa8+ZdLPbZKIbO15OiSY6B1cLR5SEMzcGiILlqBSVt93x1l7X6kJ4bkS6qlr/7A+Ypl16Ie0UjC8S0qwE2i8CCpB/jKknmN/IE/DKQGDmVuDyYVyiz7gscvh7cBzNke15hhaLcK2X4XWDhL3o3ZG0hO+ZiYLPmHuU8vHcZl4kadMX4eeSu4P7vgIG43AuYIu606qItCG3LM0imXNqG414Etzzy3sHtxDUCPapPZZu0u3T6Jrhh8i86afyuue6tCMjRPiljgpFK8GhCV+T1hu8kAMwz/CBoePlDgJzYdeZDzn4HqPK3DvvAdQybneJsoxLHMbjbeC3vZqo9Wk5ysDnNFOjBsY9JnvgnbTzOHrLvVriKfjrX9gmDxUZCVsDFahAjnWFeUSIy8NK4kBdNMRw6ueX2CTRgouNpXnVQZFVf2IAFrckXJ/J0kqOwBKCI2gp38F0iicvQhlaM1qSUV0VuycY6aPUEqv566RM
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR02MB131028CA6114F61BD0DABDC5B0AB0@SN1PR02MB1310.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501244)(52105095)(10201501046)(3002001)(93006095)(93004095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);
	SRVR:SN1PR02MB1310; BCL:0; PCL:0; RULEID:; SRVR:SN1PR02MB1310; 
X-Microsoft-Exchange-Diagnostics: 1; SN1PR02MB1310;
	4:SDFJj+pkCVxNY8iJq+fwD0ZAk7ZfBaFHh89tUbaG8wgpVxCdM7Wyu7DWE2V099CEiJiixyb4g8SYXy1Ou+rED/AScchFxN8wvMEqZb5uS5VJrBP7w4MjFtMImH70idYZdUiFhqqoMvg5ZTqHDDldAhF0BUUWeieXylUJOwG4HN/I3KpgEP/m0eQnijspXdkyUTRxyv+Susb+luX24pEK94FX4nv39BeXYllqgnAGUwNi90mETChCtoi7cbQHEh46KxHd4l/xjiqdA24Ag+73F079YBdUypLtm4ojxvYEkJ+DnPi0TjPTs/foU5TvS9+l
X-Forefront-PRVS: 061725F016
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; SN1PR02MB1310;
	23:zTm7PmtcnySLNr0pb1FDB3IZS/Q84amW7SwFbeagN?=
	=?us-ascii?Q?a7Zdcw9h2YW1khNIhj8gfnLylRYZbSe3fA3TmOj7uNjofvE9AmZ09r3GZAQv?=
	=?us-ascii?Q?DwU8l/Q9Z1KfiDb8qySNecLs3UNAZ8TcJgpz5fv5Ul43+VTdpY+/xoH2FCs0?=
	=?us-ascii?Q?rGcI+3byL8RiTIgCpohS57d8XCehKeUcmqnUuRSPtGAzztZQCUXB824LjIWR?=
	=?us-ascii?Q?IVEJWXzotJRm0ERjHoNgs3fWlQW1p2l/M2uiZJwJ5YZz9gPX7WqVNsuu3pp/?=
	=?us-ascii?Q?SJm6yBSg6nx+dsNS38KDcINYv+9hAu+bpXeHGDwDi7C5bFpGRfZZaOBbBUak?=
	=?us-ascii?Q?z/jCmXohBezFK3cJhFiQ11Yx2CViYXEoK63K2s3jI4tidRLyB+ka1zjDLXSs?=
	=?us-ascii?Q?CGAJy/jt9oibNaGfl5X8S/trSxam9+cl5T5aeAOa/ytbc+rklfaus5lt4OHB?=
	=?us-ascii?Q?qHKQHfQ8raHH/35vbZPHiLYwtRczRHJhKLvFQYtbZu/8x37Zg5tQQknVenbo?=
	=?us-ascii?Q?mwMZqNWrOShFmYJOW8N5VsHlC9Gm8MCmpiulfc1m3v6obaSz3jb6P8CPkU31?=
	=?us-ascii?Q?5WSBrXWzNzvjuuXX8wQXTfnVgOVExWYmAR52fSvmePNjY4iONDdHDGNRRM7a?=
	=?us-ascii?Q?qaCuBBisG+0OmJsmCmvQXn8Pqnc4QceIKjwNMufxKmja048LuNAJcSo6zwXB?=
	=?us-ascii?Q?Y85Fh0K4R9LFPep/IXIL2ULxKCsLSp1k9AbIL5Y0BqnJWWgkXtY3imN6jxUt?=
	=?us-ascii?Q?cFBoQ8BfwNoSkxD0LtV84cii0GlmaVmHUzuFSJ2Fw+KOkps9Ow6nuNOJty/g?=
	=?us-ascii?Q?s4QtyPd3a3XiJcbbKhU2w9qSJlzUlpBUuixPJC1UU6v5hVpyxM1KeU8nRCph?=
	=?us-ascii?Q?DJlenIygDiFD8MyfTXeayq9RxT1b4tUgN9oSBMppIO6lgE/qkniBgPmDBYjQ?=
	=?us-ascii?Q?t63QOe4/od6I9vTjN3Ck5Mt6gwUAUdwPbpdVbZ/KyC9uv+L20GlREP/VWaZ4?=
	=?us-ascii?Q?bJVoR3mCHKW709J/9Gl8J9t+HqvStnL9OEYyvJhL8gqm3J2mWUp6E4Hn0oxQ?=
	=?us-ascii?Q?nbmny5SOfNT35QrsxM8BP2jPQnLq4XFtvJOKadwDzJl6XaIx3AVE0vTtev47?=
	=?us-ascii?Q?re7jTCS2rA=3D?=
X-Microsoft-Antispam-Message-Info: ae2j+bXuyNaIOa8/vwermAmNvCo6iT4rATGeuWOK9nNOE/wn7dcpVWK76EIo+Ed3Rs1D9FxCSaWwBN/MIVPbIChdZ4w6vY24gD0FHl5agZI6GKiVfmFi5V5SVS4f4AgQB4GJRJjbZ97s3Nb07BqrLRhMQPtDSFEXRELZC2qXxOKWgzKYOFrJ1Dr/6kuNRcaI
X-Microsoft-Exchange-Diagnostics: 1; SN1PR02MB1310;
	6:5WoNZGDKNWcyZf2PqCcIWgjlLImHhRobMUOX0VGLw/rSQ6IiCplEs0E7y5TxEQ6C1UFbi6doyVuvO8JVmiyq9GLvYWZZfAdxWQqOR4uJdZ4j13x6/KUtOhHjmdoPro0jXVs1mxLppEU0a7c/wvCK54DngEEDLd8v1/0R6wOrP0IXjybZNcNIPQLJWUMjdDKpiiVZvDRA16Ux+KGcx8Uv9w9SfqEOiCwt0CpIRyNMeyMAHuQkVkJJhOMv5EQVQTnSJruQLlgw6x8mcHuzBWUrbGSn+/AgpKECWDDq9TGfSjBI200Sy8Yt3n5UuwQZT2JacDii/DKA35wJhhAUk0t/fTfoguDQSkLVgcsI6SB5HQ0=;
	5:DV6M7UcYv2xhoBVV7TKdwqfZt2HOM2EOPB9d9Inrz6QBZpm0FkiwZ0PKuWF6mBoJzBzelWFhcRQLWCh4x+UPT2KjxkUoWPjdEATjEJHyLwRy6ROVc4y+XRoNzM5RE8Y3RXaSnfV9YYPyy36mn27GbthRzoh4Y8/6cZyTxFqc8T4=;
	24:i42fmV2ZFo/HeZcHkwkvIQ3Kz5n37oGVi8WXKCmJFhgbpnZAe9qPTonajP9OtV6fBURoJtshbPqfkRBp08V5AtEcQj0WAfYVWdABe8s+v4U=;
	7:DqkWyNY2nWmLzUHfGQJVMuzWfgnspsnBkxQCcjKmRfRQHW4Q25WsA4WLe4srpRDY55UPwJ1PQEPXacjT9wK7DYuU6tP6J+2D4ChyTj06V/Pkk9JRQV243Jr6VG537nt5szR63BUCY1XnrOhiazA2ZSoxpcJFwlFKRnkZke4zIKTnyEC+NcDaFfr7PLdhUq5zILfnAoDYrIHy5Yf6UOuQdFmkYpmF07+6aUpdcsB2MqBgs3PWcSZp5FCCniX0tOB8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2018 20:40:18.9223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9f242d-9f4e-4c95-fdb5-08d58ea2cb65
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;
	Ip=[149.199.60.100]; Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB1310
Cc: Bhargava Sreekantappa Gayathri <bhargava.sreekantappa-gayathri@xilinx.com>
Subject: [PATCH] wget.py: handle BBFetchException
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
X-List-Received-Date: Tue, 20 Mar 2018 22:13:22 -0000
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

When BB_NO_NETWORK is set to 1 and the first mirror url needs network
access, then bitbake will just fail and report error instead of going
through the list of mirror urls. This is because BBFetchException is not
handled when wget is called.

This patch calls wget with a except blocks which returns to the previous
function instead of failing immediately.

Signed-off-by: Bhargava Sreekantappa Gayathri <bhargava.sreekantappa-gayath=
ri@xilinx.com>
---
 bitbake/lib/bb/fetch2/wget.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 7c49c2b..95970d1 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -118,7 +118,12 @@ class Wget(FetchMethod):
         else:
             fetchcmd +=3D d.expand(" -P ${DL_DIR} '%s'" % uri)

-        self._runwget(ud, d, fetchcmd, False)
+        try:
+
+            self._runwget(ud, d, fetchcmd, False)
+        except bb.fetch2.BBFetchException:
+            return False
+

         # Sanity check since wget can pretend it succeed when it didn't
         # Also, this used to happen if sourceforge sent us to the mirror p=
age
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.

