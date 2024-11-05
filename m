Return-Path: <jsbronder@cold-front.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58018D3E77D
	for <webhook@archiver.kernel.org>; Tue,  5 Nov 2024 22:52:29 +0000 (UTC)
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mx.groups.io with SMTP id smtpd.web11.33404.1730847145847254008
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Nov 2024 14:52:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cold-front.org header.s=fm1 header.b=EuqLWQZR;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=hP8jJz2e;
 spf=pass (domain: cold-front.org, ip: 202.12.124.157, mailfrom: jsbronder@cold-front.org)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2E3DC2540073;
	Tue,  5 Nov 2024 17:52:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 05 Nov 2024 17:52:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cold-front.org;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1730847145; x=1730933545; bh=1YfHC2e+tOTmbNNBhrZjqbW4dw2e7xKX
	jopcIJW6LFs=; b=EuqLWQZRMP2ibR8pWoWZJ05o52qezIQQDAYRX89zCGc2donQ
	x8tqvWfMH1aQkYG52IHY85YcvxiHlFsnFLIoRh46dt5rDO6x2lhZLsPs/T7qgfFa
	4FDxn6eOER6RH3q63I2lCgsJANyMDWivbCIEj+xQyt1FDX3L/651XNsyqx3EIhUu
	gdpqbcTzf4WEg2gQQZiu9rQjS69ON/mgC3KAzptvUOg94QgoYwWX2+zuO84x5eec
	oN8yoMJBb5/vM0XHCEM0tiGv12aJDxwSt7M95MyVomY5ToL1a/294n5zM5HSUfoi
	RCoWrRMNmgSiEp1nw9ylVaPxh7Jqrvy/VBju9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730847145; x=
	1730933545; bh=1YfHC2e+tOTmbNNBhrZjqbW4dw2e7xKXjopcIJW6LFs=; b=h
	P8jJz2etQOxRuARWafdZij9lfCVghBhqT25H40/RHHfsHFjcglDSe/9K3oR+dZNi
	iKg9iIWCaxVNQuICCiyabXbzQKl8JLgEcrFUwRPWqoH3pTAm9vv7Y7sET5BGIVyn
	5H7Y7kTZbNucv/lS0vExTQHEsPijc4MIgsWrFApkGMsttvO/yLmx/XoVdn/ChJNr
	EM6OaFHmKHWCZgXk2YjslYT1ETnFHwvuWFbEGXLhlKRkK9d8f3Rxz7WKAEWZID43
	gFqiU+NwtxhlP/+DcRYBrh5+9Ing1R2Kv3Qc3pvA3xpfe4G0IzLVKf6ygskGrt7i
	bvJXqamAqqZF4/MIMEtNA==
X-ME-Sender: <xms:qKEqZ8OS2Gd5KsdLCCpukX8xJP-Ton1ZNrkS7x1psKzOgKu8UInt2g>
    <xme:qKEqZy_Ly3igTrIN31hRy-_ZRzqNQXwJQkzbuZ3ap8ejRQK89fWkGpzWKEzwQzyfs
    nhi11L9cUoS9Jp7Rw>
X-ME-Received: <xmr:qKEqZzQVBpAhHNhzNfs_hEvOfPfTTlqPXVchZyDR1fE6b8j85wHCmLylTS7dclPyDKhYyTQK0sHp9yMWoqeRzsvz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddugddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefluhhsthhinhcuuehrohhnuggv
    rhcuoehjshgsrhhonhguvghrsegtohhlugdqfhhrohhnthdrohhrgheqnecuggftrfgrth
    htvghrnheptdelfeeitdevueefueeltdduhedvudefudefhffhteeigfekgfevhffhtdff
    ledvnecuffhomhgrihhnpehophgvnhgvmhgsvgguuggvugdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjshgsrhhonhguvghrsegt
    ohhlugdqfhhrohhnthdrohhrghdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepjhhpvgifhhgrtghkvghrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvg
    gurdhorhhg
X-ME-Proxy: <xmx:qKEqZ0srd7L-OmaU1C32jrOXTO150-kbnIPU3AlqJq-hh3JHF-GRgg>
    <xmx:qKEqZ0eVCj3aH72JDuPpGuqQd3oX4m7v6kMlSAKv_wnXFyGfct_0HQ>
    <xmx:qKEqZ431-S8FGuqx9s9sHlZm7tTRW3qh2fhAOsKL13zWgllQrMJZLA>
    <xmx:qKEqZ4_MoxaBXql6P7tMO6uw_OvmNx38FwQoSLbX_tZt4kPr12xXAw>
    <xmx:qaEqZ1pkItqn-X6UDHqZXtALCzrMJU0nljb6pCHtZiFLQgrzn8Ri09en>
Feedback-ID: iea0042cb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 17:52:24 -0500 (EST)
Date: Tue, 5 Nov 2024 17:52:23 -0500
From: Justin Bronder <jsbronder@cold-front.org>
To: Joshua Watt <jpewhacker@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: asyncrpc: timeout attempting to create a TCP connection
Message-ID: <Zyqhp_v1RdvE-Yh1@ravine.members.linode.com>
References: <20241105154238.3611453-1-jsbronder@cold-front.org>
 <CAJdd5GaL4tOJAREOfXp5vzeQ+zrrL41Sio1e8XaktoDM7=fk5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJdd5GaL4tOJAREOfXp5vzeQ+zrrL41Sio1e8XaktoDM7=fk5g@mail.gmail.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Nov 2024 22:52:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16783

On 05/11/24 15:06 -0700, Joshua Watt wrote:
> On Tue, Nov 5, 2024 at 8:42 AM Justin Bronder via
> lists.openembedded.org
> <jsbronder=cold-front.org@lists.openembedded.org> wrote:
> >
> > Timeout when trying to connect to an upstream that may be filtering
> > connections (instead of waiting endlessly) and raise a ConnectionError
> > which will allow the caller to note that the client is not connected.
> > This, for instance, ensures that a firewalled BB_HASHSERVE_UPSTREAM will
> > trigger warnings.
> >
> > Signed-off-by: Justin Bronder <jsbronder@cold-front.org>
> > ---
> >  lib/bb/asyncrpc/client.py | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
> > index 9be49261c..92e140dfe 100644
> > --- a/lib/bb/asyncrpc/client.py
> > +++ b/lib/bb/asyncrpc/client.py
> > @@ -68,7 +68,12 @@ class AsyncClient(object):
> >
> >      async def connect_tcp(self, address, port):
> >          async def connect_sock():
> > -            reader, writer = await asyncio.open_connection(address, port)
> > +            try:
> > +                reader, writer = await asyncio.wait_for(
> > +                        asyncio.open_connection(address, port),
> > +                        timeout=5)
> 
> Use self.timeout instead of "5" so that users can configure this
> through the normal timeout methods.

I did that initially and you're correct to call me out on this.  I should have added more context to my commit message.  With a shorter timeout I get the warning 'BB_HASHSERVE_UPSTREAM is not valid, ...' from BBCooker catches the ConnectionError in handlePrServ.  That's the behavior I believe is desirable.

When I use self.timeout (or longer timeouts in general), bitbake exits with:
    Timeout while waiting for a reply from the bitbake server (60s at 17:27:09.872219)
and bitbake-cookerdaemon.log has BrokenPipeError being raised from python multiprocessing.


I started debugging this but then couldn't figure out how a user would actually configure the timeout.  At least neither PRAsyncClient or the hashserv client look like they're setting it.  So at that point I figured a static, shorter timeout for failing to connect would be reasonable.

If that argument doesn't pass muster, I'm happy to continue trying to figure out why using self.timeout isn't getting the warning from BBCooker but I suspect it's due to competing timeouts in separate modules.


> 
> > +            except asyncio.TimeoutError as e:
> > +                raise ConnectionError(f"Timeout connecting to {address}:{port}") from e
> >              return StreamConnection(reader, writer, self.timeout, self.max_chunk)
> >
> >          self._connect_sock = connect_sock
> > --
> > 2.46.1
> >
> >
> > -=-=-=-=-=-=-=-=-=-=-=-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#16778): https://lists.openembedded.org/g/bitbake-devel/message/16778
> > Mute This Topic: https://lists.openembedded.org/mt/109407941/3616693
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWhacker@gmail.com]
> > -=-=-=-=-=-=-=-=-=-=-=-
> >

-- 
Justin Bronder

