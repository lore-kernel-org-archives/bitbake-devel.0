Return-Path: <y.leckel@yahoo.de>
Received: from sonic304-49.consmr.mail.ir2.yahoo.com
	(sonic304-49.consmr.mail.ir2.yahoo.com [77.238.179.174])
	by mail.openembedded.org (Postfix) with ESMTP id 9DC2D7C673
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Feb 2019 13:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s2048;
	t=1550582813; bh=8WAO+/mBQ1jSR4NQuwIzbBRjBBJLZ+ESVR2Nl34Aw5E=;
	h=Date:From:To:Subject:References:From:Subject;
	b=p5UObaHQsaK3ZFkg+TaARSUdDp+M8cLk36K0RdowiCHgFUNNZZDW+H4nSeiu1FFrSHf8eywBiKnegEfCWoxpe1REmKrL+AenC4GAHBsohcCJgC1/YNvkjH+RGzUCGf0iCYTkLkicGApCPt2lLgTy+GQ6h3piPZSnoA35DV4K9rQtzj9LM+gH92HZ0OSFVRAle6LTsMSL7VP8RFgUTZV0SxtNx9YCDvvptQkTRqyDN7N3Nb6T3DnbW12LHn/psbFlOhf1d9+fZDRzjVbYbrOcnGPiFL9mV4aTWr2MiND5N3yiZqj8rPEB+1rj27/mIG6mqtD+TUpvmcBnAwM02DEHYg==
X-YMail-OSG: JWsNoaQVM1kOG1uzN75yMi9Vj5HqWsZd1mDZbtDyXD98R9VJeiDa_SORJiy1ALv
	HXfC7lylgJdaCveTy0HAl17.ESEaQMo77iWhov4cr98kzjqvt_Rvyu1ukxT9NmkFfM0gt3_jSCI6
	N7LDQfmqNdVI8ye0sLPo2_zo4mwYfVyR6FTwrB13bu8a7K.Ce_C4c.0utlR4TV92PObmPDmUymJK
	S9BqRvblw6Ji8k5SQuWmGzKDKXX_Wfv8QURds_YOWi5Be1aKcBpjC5iU.lGmct44hlax61SI150o
	72cVfk5VfI.xbd2b4xgq19qWqHex52Och2KD3.Kc.laxZ50gQildx5krzD41U5sCVufv8DBK6J1.
	jucu02GS_HY.xQWwVgAnaJ14Bh3mZQlr92av70cF8eCUsV.iZxUn10oVDRB.vvFjdlbtmlAy2Urn
	erofSYOvspb0R.LXqY4Y4VZws1I1zgXFqtTjvk7ElzbU_WppcDtLeqh7DuyyLfOsxDdVlviq5PcE
	J_LATE4PtF7TbtNvWwSZXmhXhra.lleLRQv1i1aB.lVIqKfC6Cu1pa6XkiEknvt48i1_pW_9I_OL
	VqkX9_Jyk4hIncEoGp7Sb0EUqIfmf2FMOzXOL038CChwI14VlZv5le3GO60FuVNYwqUSK80Gfh82
	YAd4kxGjNixCCyGs6pgpZpBRBiB5.5NdXf5Eryug3fC6wfZ3ayEtnZXhxVfr.i_hnh6F7vMOhuE.
	7_RKDgIvdgKqopf3RhIjS3etAeQmX4DKEow5DBc4sQ.bbzccSlgnzVkq8P4ck1q.3osKC8vIHjG0
	BKc.BkHgyiAHOF8wssZeon7cy.GdoB1xjoaZsm4ZRFAapgsfrb9_teT4XoehudRtU6B7OcphRVKT
	5HIMDqlX5HnCXhKohOpYujn4eF_37rXI6xY10bsrZeBJ19jB789R7fGAA_4j3pJSHqCOc9x5wQBm
	XJqyNabzXSosAeN8d0gAdLkbCElFV0JB7D2TF61fT9tDJ59BSINLZKmTQ432s_vIGUDYm_zAqC8M
	TDH6AkWj726_Dp8DNZ_sQsXLFV_W5lENY8eaSs_5igndsizUHHi6TXkMizrnY6iXGrvo2iI9l2IB
	ZxEs_Q4qpK2Dj5h0Syi7r0GbOCDenmFBU2sQ5ed.Qjmizat3ntPU.YRHV.G2U501Y
Received: from sonic.gate.mail.ne1.yahoo.com by
	sonic304.consmr.mail.ir2.yahoo.com with HTTP;
	Tue, 19 Feb 2019 13:26:53 +0000
Date: Tue, 19 Feb 2019 13:24:51 +0000 (UTC)
From: Yanni Leckel <y.leckel@yahoo.de>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Message-ID: <956348467.2677382.1550582691815@mail.yahoo.com>
MIME-Version: 1.0
References: <956348467.2677382.1550582691815.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.13123 YMailNorrin Mozilla/5.0 (Windows NT 10.0; Win64;
	x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.109
	Safari/537.36
X-Mailman-Approved-At: Tue, 19 Feb 2019 23:10:41 +0000
Subject: Code coverage above all software components
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
X-List-Received-Date: Tue, 19 Feb 2019 13:26:54 -0000
Content-Type: multipart/alternative; 
	boundary="----=_Part_2677381_2071296331.1550582691814"

------=_Part_2677381_2071296331.1550582691814
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hey bitbake team,
I have a lot of software components to build.
I want to do code coverage with the tool gcov.
My question is how and where do I change the configuration of bitbake that bitbake creates code coverage for each software component that bitbake builds.

Thank you for your help.

best regards

------=_Part_2677381_2071296331.1550582691814
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head></head><body><div>Hey bitbake team,<br>I have a lot of software components to build.<br>I want to do code coverage with the tool gcov.<br>My question is how and where do I change the configuration of bitbake that bitbake creates code coverage for each software component that bitbake builds.<br><br>Thank you for your help.<br><br>best regards</div><div class="ydpf78a6760yahoo-style-wrap" style="font-family:Helvetica Neue, Helvetica, Arial, sans-serif;font-size:16px;"></div></body></html>

------=_Part_2677381_2071296331.1550582691814--
