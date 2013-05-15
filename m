Received: from gateout01.mbox.net ([165.212.64.21] helo=gwo1.mbox.net)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <drosen@electric-cloud.com>) id 1UcUCg-0000xP-8i
	for bitbake-devel@lists.openembedded.org;
	Wed, 15 May 2013 07:24:47 +0200
Received: from gwo1.mbox.net (localhost [127.0.0.1])
	by gwo1.mbox.net (Postfix) with ESMTP id 3b9NvY3mPXzfkfGK;
	Wed, 15 May 2013 05:03:37 +0000 (UTC)
X-USANET-Received: from gwo1.mbox.net [127.0.0.1] by gwo1.mbox.net via mtad
	(C8.MAIN.3.82G) 
	with ESMTP id 219ReoFDh1712Mo1; Wed, 15 May 2013 05:03:33 -0000
X-USANET-Routed: 3 gwsout-vs Q:bmvirus
X-USANET-GWS2-Tenant: electric-cloud.com
X-USANET-GWS2-Tagid: ECEP
Received: from S1P5HUB4.EXCHPROD.USA.NET [165.212.120.254] by gwo1.mbox.net
	via smtad (C8.MAIN.3.90S) 
	with ESMTPS id XID418ReoFDh3337Xo1; Wed, 15 May 2013 05:03:33 -0000
X-USANET-Source: 165.212.120.254 OUT drosen@electric-cloud.com
	S1P5HUB4.EXCHPROD.USA.NET
X-USANET-MsgId: XID418ReoFDh3337Xo1
Received: from [192.168.1.124] (67.169.86.1) by exchange.postoffice.net
	(10.120.223.34) with Microsoft SMTP Server id 14.3.123.3;
	Wed, 15 May 2013 05:03:32 +0000
Message-ID: <51931723.5080409@electric-cloud.com>
Date: Tue, 14 May 2013 22:03:31 -0700
From: David Rosen <drosen@electric-cloud.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:17.0) Gecko/20130329 Thunderbird/17.0.5
MIME-Version: 1.0
To: <yocto@yoctoproject.org>, <bitbake-devel@lists.openembedded.org>
X-Originating-IP: [67.169.86.1]
Subject: Bitbake build visualization
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
Reply-To: drosen@electric-cloud.com
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 15 May 2013 05:24:47 -0000
Content-Type: multipart/alternative;
	boundary="------------080506070309090000090903"

--------------080506070309090000090903
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

As a newbie to bitbake and Yocto I have attempted to explore the 
behaviour, characteristics and performance of bitbake, through the 
simple steps documented in the quick start guides on the Yocto Project 
website. As part of this learning process I came up with a utility that 
helps in visualizing and understanding the parallel distribution of the 
various bitbake tasks across the build machine, as well as providing 
some additional metrics and reports. More details available here:
http://www.electric-cloud.com/blog/2013/05/10/yoctoopenembedded-bitbake-build-visualization/

As-is, my thinking is this may be useful for the wider bitbake and Yocto 
communities, hence I wanted to share on these mailing lists.
If there is value here, are there other features or capabilities that 
would be worthwhile to consider? Any other thoughts or feedback?

Disclaimer: ElectricInsight, (the visualization part of this utility) is 
free but proprietary software, currently gated behind a simple 
registration form linked from the URL above.

Thanks

David Rosen

-- 
*David Rosen* | Product Manager | Electric Cloud | +1-408-419-4313 | 
drosen@electric-cloud.com

--------------080506070309090000090903
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="content-type" content="text/html;
      charset=ISO-8859-1">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Hi all, <br>
    <br>
    As a newbie to bitbake and Yocto I have attempted to explore the
    behaviour, characteristics and performance of bitbake, through the
    simple steps documented in the quick start guides on the Yocto
    Project website. As part of this learning process I came up with a
    utility that helps in visualizing and understanding the parallel
    distribution of the various bitbake tasks across the build machine,
    as well as providing some additional metrics and reports. More
    details available here: <br>
    &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
<a class="moz-txt-link-freetext" href="http://www.electric-cloud.com/blog/2013/05/10/yoctoopenembedded-bitbake-build-visualization/">http://www.electric-cloud.com/blog/2013/05/10/yoctoopenembedded-bitbake-build-visualization/</a><br>
    <br>
    As-is, my thinking is this may be useful for the wider bitbake and
    Yocto communities, hence I wanted to share on these mailing lists. <br>
    If there is value here, are there other features or capabilities
    that would be worthwhile to consider? Any other thoughts or
    feedback?<br>
    <br>
    Disclaimer: ElectricInsight, (the visualization part of this
    utility) is free but proprietary software, currently gated behind a
    simple registration form linked from the URL above.<br>
    <br>
    Thanks <br>
    <br>
    David Rosen<br>
    <br>
    <div class="moz-signature">-- <br>
      <font size="-1" face="verdana" color="gray"><b>David Rosen</b> |
        Product Manager | Electric Cloud | +1-408-419-4313 | <a
          class="moz-txt-link-abbreviated"
          href="mailto:drosen@electric-cloud.com">drosen@electric-cloud.com</a></font>
    </div>
  </body>
</html>

--------------080506070309090000090903--
