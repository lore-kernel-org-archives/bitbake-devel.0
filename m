Return-Path: <forums@bitflipper.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C10C28D13
	for <webhook@archiver.kernel.org>; Mon, 22 Aug 2022 19:24:06 +0000 (UTC)
Received: from omta033.useast.a.cloudfilter.net
 (omta033.useast.a.cloudfilter.net [44.202.169.32])
 by mx.groups.io with SMTP id smtpd.web08.22570.1661196244034621458
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Aug 2022 12:24:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bitflipper.net header.s=default header.b=crJi6ViF;
 spf=pass (domain: bitflipper.net, ip: 44.202.169.32,
 mailfrom: forums@bitflipper.net)
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTP
	id PzXjoUKoqh3t8QD1mokM95; Mon, 22 Aug 2022 19:24:03 +0000
Received: from gator4161.hostgator.com ([108.167.133.17])
	by cmsmtp with ESMTP
	id QD1kosOUGp7pVQD1lo6bfA; Mon, 22 Aug 2022 19:24:01 +0000
X-Authority-Analysis: v=2.4 cv=Cr+sz10D c=1 sm=1 tr=0 ts=6303d7d1
 a=wy83rNxz+atVFkX2aYqp/w==:117 a=aN6y9qdCXCRkBQVezpBZ3g==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=biHskzXt2R4A:10 a=myVjTR8LsXQA:10
 a=Kw0Nh6hiwHLgQ-Elx6EA:9 a=QEXdDO2ut3YA:10 a=1MXsooTFzbQZieEm:21
 a=_W_S_7VecoQA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=bitflipper.net; s=default; h=To:Date:Message-Id:Subject:Mime-Version:
	Content-Type:From:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rPliUp4FYl0FRy123QO2KSDZSsH4QS1deIsdBjm+1yQ=; b=crJi6ViF/9xlOQpKMMyqMDoZcC
	NTbBhcxsB39oCti0oou0ajBByG0MB2WMSmLdOordcKQ482Fm0bfHNuWr8Qj6gofX8l6vixs9Nc1nJ
	ju+wJVQo7KIXVr53cMA9PwEVcVenELPSKHcPfpA++zlJnsWPmq67MgcYqBJIsDpO4qg+qnBEkMrNL
	Vg7ulq3WagA5BSOAM9iiiHrQ8BEerQg1zAri26F4RLmaiUBOhyY68kHLtS81UL0kBYDs5WuU9LlDW
	Upae9RJpMEm70kInIzPubzXm3vX4baUkliLv6T7hA2IcQI26/bKGHAK5EpvZDyTK4e67XhJOtXhdl
	TIe0J+dg==;
Received: from pool-108-20-201-51.bstnma.fios.verizon.net
 ([108.20.201.51]:51347 helo=smtpclient.apple)
	by gator4161.hostgator.com with esmtpsa  (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <forums@bitflipper.net>)
	id 1oQD1k-002xGT-7w
	for bitbake-devel@lists.openembedded.org;
	Mon, 22 Aug 2022 14:24:00 -0500
From: forums <forums@bitflipper.net>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_A823EDAF-D554-4395-8AFC-A8667A54EC91"
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Bitbake + Patching
Message-Id: <535F3AC6-0FB2-4559-AFE9-A7DE98519735@bitflipper.net>
Date: Mon, 22 Aug 2022 15:23:58 -0400
To: bitbake-devel@lists.openembedded.org
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4161.hostgator.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - bitflipper.net
X-BWhitelist: no
X-Source-IP: 108.20.201.51
X-Source-L: No
X-Exim-ID: 1oQD1k-002xGT-7w
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-108-20-201-51.bstnma.fios.verizon.net (smtpclient.apple)
 [108.20.201.51]:51347
X-Source-Auth: forums@bitflipper.net
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: YmFsc29uODg7YmFsc29uODg7Z2F0b3I0MTYxLmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: 
 MS4xfGQ8IW64WLZHSfN9QwOXFXIF3Byd8yGCcGnE66EeF0PSqPOrD2BwBet7Xh1WUWNl2jF+OLWzmHaLw4ATq7wORMNmJ4uK1dN2Q5Y6a/sohTAjJ1SNSiup
 UfiGbUaHBchYDz2WjVL2LRjQksqtblYEbk6dsvzGN3AZMdgEBmamFzVVTglx43KiQwuyzigObkBT8ngHztaQqgSUhEy0eElk3PKWb81S3fb5Wg1NY6lGXz5k
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Aug 2022 19:24:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13928


--Apple-Mail=_A823EDAF-D554-4395-8AFC-A8667A54EC91
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8




HI, I don=E2=80=99t think this is the right email to be poosing this =
question to, but I am hoping that you can point to the right place where =
I can get my answers. The problem I need to gain more insight on is the =
following:

We are currently using  Zeus, and with Zeus, we get Apacje v2.4.41. But =
I would like to get a later version of apache because of there have been =
a few fixes related to cyber security. So I believe that, given we=E2=80=99=
re using Zeus, we can=E2=80=99t upgrade to the latest version of Apache =
vis the current recipe that Zeus uses. Therefore I believe that the only =
way accomplish getting tho the latest version of apache would to be =
=E2=80=98patch=E2=80=99  the v2.4.41 version that comes with Zeus.

Looking at the Bitbake manual, in section 4.1, it states the following:

"BitBake takes several steps when fetching source code or files. The =
fetcher codebase deals with two distinct processes in order: obtaining =
the files from somewhere (cached or otherwise) and then unpacking those =
files into a specific location and perhaps in a specific way. Getting =
and unpacking the files is often optionally followed by patching. =
Patching, however, is not covered by this module."


The manual does not cover patching.=20

Where can I get information on this process of patching something like =
apache or any other application that was add via IMAGE_INSTALL_append =
method.

Any help pointing me to where this process might be documented is much =
appreciated.


Thanks, Jim


--Apple-Mail=_A823EDAF-D554-4395-8AFC-A8667A54EC91
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><div =
class=3D""><br class=3D""></div><div class=3D""><br class=3D""></div><div =
class=3D""><br class=3D""></div><div class=3D"">HI, I don=E2=80=99t =
think this is the right email to be poosing this question to, but I am =
hoping that you can point to the right place where I can get my answers. =
The problem I need to gain more insight on is the following:</div><div =
class=3D""><br class=3D""></div><div class=3D"">We are currently using =
&nbsp;Zeus, and with Zeus, we get Apacje v2.4.41. But I would like to =
get a later version of apache because of there have been a few fixes =
related to cyber security. So I believe that, given we=E2=80=99re using =
Zeus, we can=E2=80=99t upgrade to the latest version of Apache vis the =
current recipe that Zeus uses. Therefore I believe that the only way =
accomplish getting tho the latest version of apache would to be =
=E2=80=98patch=E2=80=99 &nbsp;the v2.4.41 version that comes with =
Zeus.</div><div class=3D""><br class=3D""></div><div class=3D"">Looking =
at the Bitbake manual, in section 4.1, it states the =
following:</div><div class=3D""><br class=3D""></div><blockquote =
style=3D"margin: 0 0 0 40px; border: none; padding: 0px;" class=3D""><div =
class=3D""><p style=3D"line-height: 1.5em; margin-top: 0em; caret-color: =
rgb(51, 51, 51); color: rgb(51, 51, 51); font-family: Verdana, Sans, =
sans-serif;" class=3D"">"BitBake takes several steps when fetching =
source code or files. The fetcher codebase deals with two distinct =
processes in order: obtaining the files from somewhere (cached or =
otherwise) and then unpacking those files into a specific location and =
perhaps in a specific way. Getting and unpacking the files is often =
optionally followed by patching. <b class=3D""><i class=3D"">Patching, =
however, is not covered by this =
module</i></b>."</p></div></blockquote><div class=3D""><div class=3D""><br=
 class=3D""></div></div><div class=3D"">The manual does not cover =
patching.&nbsp;</div><div class=3D""><br class=3D""></div><div =
class=3D"">Where can I get information on this process of patching =
something like apache or any other application that was add via =
IMAGE_INSTALL_append method.</div><div class=3D""><br =
class=3D""></div><div class=3D"">Any help pointing me to where this =
process might be documented is much appreciated.</div><div class=3D""><br =
class=3D""></div><div class=3D""><br class=3D""></div><div =
class=3D"">Thanks, Jim</div><div class=3D""><br =
class=3D""></div></body></html>=

--Apple-Mail=_A823EDAF-D554-4395-8AFC-A8667A54EC91--

