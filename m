Return-Path: <sveinse@seldal.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A240C4167E
	for <webhook@archiver.kernel.org>; Sun,  9 Oct 2022 22:31:00 +0000 (UTC)
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
 by mx.groups.io with SMTP id smtpd.web09.299.1665354656923523496
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 09 Oct 2022 15:30:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@seldal.com header.s=ds202112 header.b=x9PardWW;
 spf=pass (domain: seldal.com, ip: 194.63.252.55,
 mailfrom: sveinse@seldal.com)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=seldal.com;
	 s=ds202112; h=Content-Transfer-Encoding:Content-Type:Message-ID:Subject:To:
	From:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=375dG7lrD/S7cO/QwPliMyCFyrhidta8Wyfo/29WlGc=; b=x9PardWWZ8zeP5CRp6rq8dHOkx
	gjfPtHgY8PD/CEAQv5yR4XoSgeu6OLIM4zeP4igmRr91BIwPiPKpymSRmR3uMCRq2BJZboW5g6yGE
	T2BUp0cfPrEiMv6wudSpZMy7zDLmUzniO8RMhAStMXJ3H8JF5VDOkfsBf4cWDd5Wxs3d54XcXDSuU
	+cipY8PUom/SgzjpPb/UTVUMEQlK4UblTzDgLuZ5ZuI6nwM/Yic0JxDET5jDyaLoyXX7rRfzEvX6M
	TALf+a+K1mX/bWqwWK+az8r/zzpGTsB/q/IQ9hl5mSIBgzIiw9JbV/dAsVIpipVDReP/Skthf7APC
	OpmV/XFw==;
Received: from kubew0002.domeneshop.no ([194.63.252.152]:44399
 helo=webmail.domeneshop.no)
	by smtp.domeneshop.no with esmtpa (Exim 4.92)
	(envelope-from <sveinse@seldal.com>)
	id 1oheox-0000Df-3X
	for bitbake-devel@lists.openembedded.org; Mon, 10 Oct 2022 00:30:55 +0200
MIME-Version: 1.0
Date: Mon, 10 Oct 2022 00:30:54 +0200
From: Svein Seldal <sveinse@seldal.com>
To: bitbake-devel@lists.openembedded.org
Subject: WebKnotty UI concept test from browser
User-Agent: Domeneshop Webmail/1.5.2 ()
Message-ID: <ca6d99b8b064bf6b5ee2ecca71aeae81@seldal.com>
X-Sender: sveinse@seldal.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 09 Oct 2022 22:31:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14029

Hi

This is my first post to this mail list, so please forgive me if this is 
out of norm.

I love the knotty UI, with the progress and the churning of the 
individual tasks. However I'm often running bitbake in a tty-less 
context under a build management system and one doesn't get the nice 
pulse of ongoing activities. What if bitbake could export in real-time 
its knotty-like progress to a web page?

This weekend I hacked together a concept test of exporting the bitbake 
events over WebSocket to a crude react web application with the purpose 
of creating an output in a web page similar to what the interactive 
Knotty does on terminal. This concept can be found here:

https://github.com/sveinse/bitbake-ws-concept/tree/2.0

Briefly explained the knotty UI is modified to connect to an external 
WebSocket server and it will upload all log and events in real-time. 
contrib/webknotty/ contains a small react-based webapp that receives the 
bitbake generated logs and events and presents them on screen. Please 
see the above link to see a screenshot of the page. To connect these 
together contrib/wsproxy.py implements a small WS proxy server that 
allows bitbake and the web clients to connect.

Why not use Toaster? Well, firstly, I like the Knotty way of indicating 
build progress. Secondly, my use of bitbake is a part of a much larger 
build infrastructure, and having a WS interface allows external 
integration with the top-level build UI. Much like what the teamcity UI 
does, but still maintaining the essence of knotty.

The purpose was simply to test how this might be done. I do not have any 
opinion on the direction of bitbake, but I hope that it might be 
interesting. I'm not very familiar with the inner workings of bitbake, 
as I'm sure there are other ways this could be realized. Perhaps the 
xmlrpc interface can be used to connect the web UI? I haven't spent any 
time on the web UI and the react webapp, since this is simply a proof of 
concept.

All in all, I publish this in hope that others might find it 
interesting.


Best regards,
Svein

