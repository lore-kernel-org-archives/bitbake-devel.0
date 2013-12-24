Return-Path: <zhenhua.luo@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
	(va3ehsobe003.messaging.microsoft.com [216.32.180.13])
	by mail.openembedded.org (Postfix) with ESMTP id 3F4856AEA3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Dec 2013 08:07:01 +0000 (UTC)
Received: from mail26-va3-R.bigfish.com (10.7.14.232) by
	VA3EHSOBE006.bigfish.com (10.7.40.26) with Microsoft SMTP Server id
	14.1.225.22; Tue, 24 Dec 2013 08:07:00 +0000
Received: from mail26-va3 (localhost [127.0.0.1])	by mail26-va3-R.bigfish.com
	(Postfix) with ESMTP id 1D08B300086	for
	<bitbake-devel@lists.openembedded.org>;
	Tue, 24 Dec 2013 08:07:00 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
X-SpamScore: 0
X-BigFish: VS0(zzzz1f42h2148h208ch1ee6h1de0h1fdah2073h2146h1202h1e76h2189h1d1ah1d2ah1fc6hzz1de097hz2dh2a8h839hd24he5bhf0ah1288h12a5h12a9h12bdh12e5h1354h137ah139eh13b6h1441h1504h1537h162dh1631h1758h1898h18e1h1946h19b5h1ad9h1b0ah1b2fh2222h224fh1fb3h1d0ch1d2eh1d3fh1dc1h1dfeh1dffh1e23h1fe8h1ff5h2218h2216h226dh22d0h2327h2336h1155h)
Received: from mail26-va3 (localhost.localdomain [127.0.0.1]) by mail26-va3
	(MessageSwitch) id 1387872418587470_7782;
	Tue, 24 Dec 2013 08:06:58 +0000 (UTC)
Received: from VA3EHSMHS013.bigfish.com (unknown [10.7.14.249])	by
	mail26-va3.bigfish.com (Postfix) with ESMTP id 89D3E2C0047;
	Tue, 24 Dec 2013 08:06:58 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by VA3EHSMHS013.bigfish.com
	(10.7.99.23) with Microsoft SMTP Server (TLS) id 14.16.227.3;
	Tue, 24 Dec 2013 08:06:58 +0000
Received: from tx30smr01.am.freescale.net (10.81.153.31) by
	039-SN1MMR1-005.039d.mgd.msft.net (10.84.1.17) with Microsoft SMTP
	Server (TLS) id 14.3.158.2; Tue, 24 Dec 2013 08:06:57 +0000
Received: from localhost.localdomain (B19537-03.ap.freescale.net
	[10.193.20.127])	by tx30smr01.am.freescale.net (8.14.3/8.14.0) with
	ESMTP id rBO86soI021591;	Tue, 24 Dec 2013 01:06:55 -0700
From: Zhenhua Luo <zhenhua.luo@freescale.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 24 Dec 2013 16:06:31 +0800
Message-ID: <1387872393-4567-1-git-send-email-zhenhua.luo@freescale.com>
X-Mailer: git-send-email 1.8.4.2
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
X-FOPE-CONNECTOR: Id%0$Dn%*$RO%0$TLS%0$FQDN%$TlsDn%
X-FOPE-CONNECTOR: Id%0$Dn%FREESCALE.MAIL.ONMICROSOFT.COM$RO%1$TLS%0$FQDN%$TlsDn%
Cc: b40290@freescale.com, b40527@freescale.com
Subject: [PATCH 0/2] bitbake: fetch2: Add sanity check for SHA validity of tag and adjust SHA define order
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
X-List-Received-Date: Tue, 24 Dec 2013 08:07:02 -0000
Content-Type: text/plain

* Add the sanity check for SHA valididy when tag is defined in SRC_URI,
the check is useful for rebased git tree in which the referred commit is not valid
in branch and is saved in tag.

* To allign with above change, the priority of revision needs to be adjusted as
following, otherwise SHA defined by SRCREV will be overriden by rev/tag defined
by SRC_URI.
  a) a source revision if SHA is specified by SRCREV
  b) a source revision if revision is specified in SRC_URI
  c) latest revision if SRCREV="AUTOINC"
  d) None if not specified

Zhenhua Luo (2):
  bitbake: fetch2/git: Add sanity check for SHA validity of tag
  bitbake: fetch2: adjust the priority of revision definition

 lib/bb/fetch2/__init__.py | 19 ++++++++++---------
 lib/bb/fetch2/git.py      | 29 +++++++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 11 deletions(-)

-- 
1.8.4.2



