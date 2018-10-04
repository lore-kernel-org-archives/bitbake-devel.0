Return-Path: <chris.laplante@agilent.com>
X-Greylist: delayed 43255 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 04 Oct 2018 17:22:18 UTC
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
	(mail-by2nam01on0052.outbound.protection.outlook.com [104.47.34.52])
	by mail.openembedded.org (Postfix) with ESMTP id 5B5C2795D5
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Oct 2018 17:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=GV0kPaB7dlArW2fnlG206lg31r8MVK9GIaXYJFP9Rto=;
	b=AWRz+WnHfqKko9l+uz2lP4U1l2nMQ5jOy8dsakPfJAORDb0ezarTqGLGFB4i31VjfW22uqV7w0O+0tNxS6SzQxgJPCysXkb1UdR8WadN2HR+2KwptZRBkIpqdQZyVlnUaw+AjjuuU1h6s/aj0a1bPA0cIzPCDnuRZFs0YLX04ao=
Received: from BN6PR12CA0042.namprd12.prod.outlook.com (2603:10b6:405:70::28)
	by BN6SPR00MB250.namprd12.prod.outlook.com (2603:10b6:404:77::23)
	with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.23;
	Thu, 4 Oct 2018 17:22:18 +0000
Received: from BY2NAM05FT057.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e52::207) by BN6PR12CA0042.outlook.office365.com
	(2603:10b6:405:70::28) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.21 via
	Frontend Transport; Thu, 4 Oct 2018 17:22:18 +0000
Authentication-Results: spf=pass (sender IP is 192.25.218.35)
	smtp.mailfrom=agilent.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
	header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
	192.25.218.35 as permitted sender) receiver=protection.outlook.com;
	client-ip=192.25.218.35; helo=COS-US-IRON04.COS.AGILENT.COM;
Received: from COS-US-IRON04.COS.AGILENT.COM (192.25.218.35) by
	BY2NAM05FT057.mail.protection.outlook.com (10.152.100.194) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1228.10 via Frontend Transport; Thu, 4 Oct 2018 17:22:18 +0000
Received: from cnd6270d8d.lfs.agilent.com (HELO localhost.localdomain)
	([130.30.246.172])
	by COS-US-IRON04.COS.AGILENT.COM with ESMTP; 04 Oct 2018 11:22:17 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 4 Oct 2018 13:21:38 -0400
Message-ID: <1538673698-73446-1-git-send-email-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: =?us-ascii?Q?CIP:192.25.218.35; IPV:CAL; SCL:-1;
	CTRY:US; EFV:NLI; SFV:NSPM; SF?=
	=?us-ascii?Q?S:(10009020)(346002)(376002)(136003)(396003)(39860400002)(29?=
	=?us-ascii?Q?80300002)(438002)(29502001)(189003)(199004)(4326008)(106002)?=
	=?us-ascii?Q?(16586007)(104016004)(5660300001)(7636002)(305945005)(106466?=
	=?us-ascii?Q?001)(26826003)(186003)(6666003)(2351001)(6916009)(7696005)(2?=
	=?us-ascii?Q?6005)(36756003)(54906003)(107886003)(51416003)(44832011)(483?=
	=?us-ascii?Q?76002)(2616005)(486006)(316002)(476003)(126002)(956004)(5046?=
	=?us-ascii?Q?6002)(2906002)(86362001)(47776003)(8936002)(356003)(63266004?=
	=?us-ascii?Q?)(50226002)(246002)(1857600001)(8676002)(478600001)(336012)(?=
	=?us-ascii?Q?426003)(5001870100001); DIR:OUT; SFP:1101; SCL:1;
	SRVR:BN6SPR00M?=
	=?us-ascii?Q?B250; H:COS-US-IRON04.COS.AGILENT.COM; FPR:; SPF:Pass;
	LANG:en; P?=
	=?us-ascii?Q?TR:and.smtp.agilent.com, relay.ap.smtp.agilent.com,
	osi.smtp.a?=
	=?us-ascii?Q?gilent.com, relay.britain.smtp.agilent.com,
	cos.smtp.agilent.c?=
	=?us-ascii?Q?om, scan.am.smtp.agilent.com, am.scan.smtp.agilent.com,
	cos-us-?=
	=?us-ascii?Q?iron04.cos.agilent.com, nonbpi.smtp.agilent.com,
	ap.smtp.agile?=
	=?us-ascii?Q?nt.com, *.outbound.smtp.agilent.com,
	bastion.sgp.smtp.agilent.?=
	=?us-ascii?Q?com, *.sea.smtp.agilent.com, eu.am.smtp.agilent.com,
	relay.and.?=
	=?us-ascii?Q?smtp.agilent.com, am.smtp.agilent.com,
	ap.scan.smtp.agilent.co?=
	=?us-ascii?Q?m;MX:1;A:1;?=
X-Microsoft-Exchange-Diagnostics: 1; BY2NAM05FT057;
	1:rfpFUkQYLwsjwGA9FcXG84wCI1cUIGIbR2jM07VyNb6pD1hhBTw6Tt2uyrhfZARQogsQyxweJPjF8rWWNw3f7PPdQU9TNnftTotJlgcAVFStsKKjgsTPr2dPooEXWmgM
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f672b0e-f4c8-4082-3640-08d62a1defa7
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);
	SRVR:BN6SPR00MB250; 
X-Microsoft-Exchange-Diagnostics: 1; BN6SPR00MB250;
	3:4QfzjKowVduuPjEOgPBZBvHTOdQg6Cony97bNJchR34PyqnF7Rven2H8o54HHldjUj4yKqZHIRMeIm6cTuzTRXwrWKplW2DREuIqTnbqxnO5z8HOBeM6SC6qGvdUHkeZvR6Ts8tbCdbVSUNlGJAYwOU/Yh6InJJzEvf8+t7cr5KIgTCdJ+gWCCiiviYffdgUENE50m6z3upuLSLlVOYzfh3k2i1nTt4vO6yQXlsjwbYA4DCQML0xv6KlNGeCQEi0X9Kkiq5I/Yjv1zZnWBMn1muMjUnMpxj57df9rWqxK0qe2eosFwmOyr0TuzbuDPpG1NGsMmBtGVj+9Fy2AjTFC6sV1bymCzr13dGwSZWD7Vo=;
	25:A4omlQHrPLrbIL/HkNfIzWNFas6sBNYbULTDpm90hA9Q5fUbPNS+absHqVAV15B7kV6z7tUJMT4F7BSPhtayOtbv++tdZ1uqrb8QcRzdcG6abdoPrs/gtGZePeZ+g/SbhrxiBeMQePZ3GDl86zeh2pDpI/XaSGBtF1VTXH48Uw4GNXmC1uRv5VuuW+5EsTqX5LgE4XjokctZfIMIekJ3b7rfegwyZhzGvam4mLnx9tjzdJNySjmZerZFszS/tvM9KCQ+jAUlRFSJMZisfzcqXizFT2X/Cfr31I+mZoQulBcIm7lT1TGX4yumHVzY9opdh+Oh/Xh6HfczTio2d9AYhQ==
X-MS-TrafficTypeDiagnostic: BN6SPR00MB250:
X-Microsoft-Exchange-Diagnostics: 1; BN6SPR00MB250;
	31:ZBdnC25SYQtVTgrkgLDnN7QrqphbHCw5z/nnOTn82efteXGwZht2J4FwbIYc0G/NoMISBvhKOQoSZ3ol4HEF3vPBIgufrxiJN1f4MtvBQIZ9yxTp3OLjSXNPlbFnYnWl+J7K+mwmV4fH96YF2LPfjVtaMutgeKJYYrSDbJuWhl6EjpSWdOdtoIpmjW78xYP8JMpTfJ5gUTHopP+ZAxx08UKsHP6meJUR2XFuj1HsNcg=;
	20:FvDbwjqVaXK27pIt1A635P/kgwCCkjr/QR3gJi19k0Z00XXWQ0E0Qq0lYOBxl6CfNAwZv/e/SK299577OKI3TsmYUZPlCqgo9lK6lTTIHNlx5SGpNNd8Z66ICpKyIAj4TGHZQzsotQIqBNTkTdRxU164v8KGk860yVp6NpogBAuZFvip1k35BzIOEW4JTaI6iN8ixdiN85pSwlCXX+VEwYhrXcu05OQrpQ2U/m5+OV+tFT56iDqNdrMxl9pKzwe4bejU7iLN/RXALlqTg98hnBf8vnad/ZF1dnCGl15QTLlXZQZ+v3hNsXEYTAfSTSITOX4Ncxfhj4EcqvARpwAxAqT3PTvSUbFdrKfD0ZDcjrTu4DINAgEetK4W8ym3Hxgma3aOeR/ZW+kgamj71Hj+i/aGl7yTdtiXxp8wNXMDqHd6T5HgcxboYDpCh9DcuRZ1wnGT145TgbTgv7T1JyJsXwJgDAPM4rylR75Ez/zjwcKQss5HHGc+yM2kCfpoUr0OPGnNYXHiTAPax6l/tZHI0hRKL8ZECIkBO3wBhcTK8Y1uly7rx1rwq5+BMewXs4DrMEa2nnElp1FM5NqDNaH96kLK5isD4a0cO1xFg0VTESQ=
X-Microsoft-Antispam-PRVS: <BN6SPR00MB2506BBB1536A39E676692F28BEA0@BN6SPR00MB250.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(181592364885221);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(11241501184)(944501410)(52105095)(3002001)(93006095)(93004095)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);
	SRVR:BN6SPR00MB250; BCL:0; PCL:0; RULEID:; SRVR:BN6SPR00MB250; 
X-Microsoft-Exchange-Diagnostics: 1; BN6SPR00MB250;
	4:WzUIfwVrthXxq0rH/6LXHoVJjKOHEtOd6m6aocrLIzeI5NczLNa6yNaKt8QQcyYk0tnN/mVckxECKeUvi5vyl8hxrwxSFZ40ZX0aUEx/8YF2aeoqZe/HSxuTpYIFLEr8JavJXOGJPXDcSM1PDjj2UfEcpVNNMJV8NpJDO5QUBqiSE8ObwG7QCyuIQiLO/n2c893PU+u+cvFL7Qk62V2YxNkXhb/uJZvesYUejoCRe7kiYoFSrEpyUBq1ZkN8WN9zwTjXrxP5x8icab9kHvW2UspVlscaeQmaAg1U+9gwQSSqHcr224aNwRN7K9Y96dxX
X-Forefront-PRVS: 0815F8251E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; BN6SPR00MB250;
	23:YGGLaTQwudFNTQHTf/kgIfm8dLhxChfSCuVsGoOoJ?=
	=?us-ascii?Q?UuFJUyZyzbgOUJNktXdYrBXsd5jwDRnASWqNiSvBStXy1Bw7YYkirINNpUIB?=
	=?us-ascii?Q?DIhlTvf/4qDl961TamTCET+bX+vw7KeI7KIl6cMVo5wCVVkLuE0otwhI+om6?=
	=?us-ascii?Q?LMa3Yh65nVW6ckmTzZoYmOs+n/FEkiesj1MYnJd2CFdvaC66DgGQiGzf8kww?=
	=?us-ascii?Q?Pe5dsn1RvKKkn7DErWOYfJP7H4kY0zIqE4bFVFLvTAaeA2Tz4VyZ09zNguWD?=
	=?us-ascii?Q?geA9ZvPfxpWBdMshhoWisKWjut2sqoh2cHYjqFp3U5GVHNMXFwu//AB0n0Ye?=
	=?us-ascii?Q?ZjWSO61/PqOAOsAawC0jhHcy/+4llyhzUCfI6om8p9biXHd2JPJGyExGvJp9?=
	=?us-ascii?Q?bAB1cHYPHfCEDzbp+hiOmUOYd5d9ib2+Jqy5VKNAtd5uYFD1mj0MeBXc9DCU?=
	=?us-ascii?Q?FMGc/dOR0hsvJhRTzDXpYczivfqPnWNwQ5cMTVJQk83IfPfYzx4IVtwIDMIr?=
	=?us-ascii?Q?+vAUnmwpgX18X/GEbag/5BTP+G79cjw3HFr24tv85JFpgN3bFtfTXA42jztl?=
	=?us-ascii?Q?MhKIOhrYeS868+PXms3VOi+4WUwnEjy8zL3K1yK9H+qBrb7ewjwyjVn8I+mu?=
	=?us-ascii?Q?+Rr3qQFjcJVHRY9UZRxLyWUefIXI/BHYhZoKAnSBDWpHMtJx5bR0dXRaoOYJ?=
	=?us-ascii?Q?WrtaunQ0PQomsrQwtoO14lgzZSBltIWPh76nsUEFj4ZUtjcJNrcgRVMWzqSu?=
	=?us-ascii?Q?5tl8C9FOtzDOQSU1sH10THyiEWY1507lCOg0UhjaSaulzLzyII8misb3PW1+?=
	=?us-ascii?Q?8Jmrhb+rO8fOU326wM1i4IvtJHjWGQn+hfo75HygpYVFOJRgdEx6aaveLEYv?=
	=?us-ascii?Q?Iot9wVTOTS8NP1E1VL2meaqklYnrFn50kQ4fh9+Kn+JRxL7aIYCwl7K0SY6I?=
	=?us-ascii?Q?pTQwi4r2WMrinxGUh+1FDjdu0HlaX6hGqv7U8CvC4/Q1A2IpgDGe7Fr0JAcg?=
	=?us-ascii?Q?EvkXt0PInxU/pWxyvqfChJ8L7vtf0Q47l1Xfz+4FEUjqGKEPEi/EaTSUfiZ3?=
	=?us-ascii?Q?hJ3t+haNLtm/7/KqLQmYqI3XI+xR/Ca5fhxKV6HMo9Nr8RoYcHkWbd2B5d93?=
	=?us-ascii?Q?Lu6zWIS5YW6EDxvEwrFZL8bVnijvHfoE/SuxBaQiRl9iDXCWoe9fA=3D=3D?=
X-Microsoft-Antispam-Message-Info: 2b8f9Uckr0DdMZvMT/FYLxymySkLUfKjqxJH3+xernqvjI2OEPVwNqYDG+qBEPSL3EDksV3BNzzXxoZrcT/fWJ8wMUnuX/ZQiyIm3fUneIiUnZlkdjP88yES6rMFgE48OVxExh1w1BFRBSSAgjT1vmIHOWQnqheM5bjvHpnqZeDb6svW34GEP+eCTCCxzd5/o0tTWD/3hCk+qzPuRGXjMJwuiSHUfh5/UD3TP5qPhW4gVKbITjjBt7YD+2oCW5apu4dYl7KPoUSsaiAKzbutGi8MBHCVjtgNCW5LrLGqqGfKXjuAlzSQhwCcVC718JwVuK7EdlNN567ywepzPHPzALk2iJMyAk2m8WqtA40JbVH52n62n50lgvDt3RfNIHKvCspWNX6+7O3FR3otBnekoQ==
X-Microsoft-Exchange-Diagnostics: 1; BN6SPR00MB250;
	6:qxTVJDVWDFeH+5PlCuXf5H/AIeCuxeu4IhDhFg6LEst0FEBFlmDtQ0qd7NiQimV+hLpiWkaHdIX9Ht5NaOpKhiCiZvpNYTFb/u0m77cnBa3jafd8cUmkEaOir7QLB5iI7btziLId3eF+mRONGSkiuX4oPvQAzc7f6E2ff46hCuGcGb9Ks5oL0+gEOKyaQw8y1x2P7lI6bHodSXgyKopm4mGBjOKp/75bd1Jfjh2orhNvY/5dbID6BQ/5RyRcc6HTNGuiXGT/W7sH6GXNsMq+7tGsWSgw6I1LvXvM4Kdz38WlhFym3fLLEEpbg734RTwxdq6XPKsDnNfLnnCctbiyC8whJafhbZ8bOPXE0aW0Cm32J6jUGK5YzP0WaH63MEup6IL3dNc0BRfW8V6fciETyKQaM2nYRnczItFJt3lTCtjx42wd5e2aUDQzZkFTaN0cS8QLORrOtuDBC7lqTqWWyw==;
	5:A2QpqxLlgGW4dUWXk5KRQj/khRr9NjPgEO2izPl3j9l06blLgPiaYsYy0J94RtgRnS2JGwGNbLqGVpeY25edd4KwNzK1wlDqKN5IM5XANEuZxB3/3UbOdP+MUrS9KW6Ij8xdsEGrRicn7BTN9eGzFg6KVGDfbgGOkCI64F7sQ1M=;
	7:MnKYCaEZazDfCAupOGO1eWKbmfi9lPMso6Q+0guff3SwOZWvwey50xqAsk/a2h0IyrcVQ/Vd5bo0ZFGLNm+0r3/WcVozMeu2LxQLjttOqzF3aH04tF/pVOUIRR9iFPJU/0sm7nGv7H9CKgHKBEJk96QqzL90FToKZBCoxuYK6vmxmEPOBWQHYLr1AbkFUk+NoBTWvPBiKKn7qDaHFtjfL+HqCZQUY/qykZEsPcnQ/K08n8QPC7k7AeNBg9BvmEuH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 17:22:18.1228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f672b0e-f4c8-4082-3640-08d62a1defa7
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.35]; Helo=[COS-US-IRON04.COS.AGILENT.COM]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6SPR00MB250
Cc: srifenbark@gmail.com
Subject: [PATCH] bitbake-user-manual: fix description of BB_RUNTASK
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
X-List-Received-Date: Thu, 04 Oct 2018 17:22:19 -0000
Content-Type: text/plain

Contrary to what the manual said, BB_RUNTASK does include the do_
prefix, unlike BB_CURRENTTASK.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
index b5a7936..c327af5 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
@@ -646,10 +646,10 @@
             <glossdef>
                 <para>
                     Contains the name of the currently executing task.
-                    The value does not include the "do_" prefix.
+                    The value includes the "do_" prefix.
                     For example, if the currently executing task is
                     <filename>do_config</filename>, the value is
-                    "config".
+                    "do_config".
                 </para>
             </glossdef>
         </glossentry>
-- 
2.7.4


