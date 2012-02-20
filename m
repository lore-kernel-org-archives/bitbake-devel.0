Received: from out5-smtp.messagingengine.com ([66.111.4.29])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <walters@verbum.org>) id 1RzYxG-0006t4-AM
	for bitbake-devel@lists.openembedded.org;
	Mon, 20 Feb 2012 20:31:23 +0100
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 503CB20B30
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Feb 2012 14:15:13 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
	by compute3.internal (MEProxy); Mon, 20 Feb 2012 14:15:13 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:from:to:cc:in-reply-to:references
	:content-type:date:message-id:mime-version
	:content-transfer-encoding; s=smtpout; bh=6+svGQExUGtSxEdSnh+MNq
	HfbCI=; b=ZA2x9iffeW0ZuSwHJ7tmqBB0OJJ1qfd0il09fKpxBFBZWuq7ws4IA0
	r9gP6WfaOgjn0AGnD67WKwJv9iApIDkYN/oOlVNV2NdjdOYUyLhSuMiqIo6v4Bq2
	BS2UGSRONW5hV3VtclGHmEFZ/462vdhugPxXmiekHLNmOdQcsJg9o=
X-Sasl-enc: ACi/id/bGKnVmuVO1w+ddE1X6v2hEE7YhDQC4/knAvyR 1329765313
Received: from [192.168.1.6] (c-65-96-60-117.hsd1.ct.comcast.net
	[65.96.60.117])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0A97C8E025E;
	Mon, 20 Feb 2012 14:15:13 -0500 (EST)
From: Colin Walters <walters@verbum.org>
To: Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
In-Reply-To: <1329608182.4436.48.camel@ted>
References: <1329608182.4436.48.camel@ted>
Date: Mon, 20 Feb 2012 09:05:00 -0500
Message-ID: <1329746700.22425.2.camel@lenny>
Mime-Version: 1.0
X-Mailer: Evolution 3.0.3 (3.0.3-1.fc15) 
X-Mailman-Approved-At: Wed, 22 Feb 2012 15:25:56 +0100
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [OE-core] Bitbake Memory Usage
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 20 Feb 2012 19:31:23 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2012-02-18 at 23:36 +0000, Richard Purdie wrote:
> As soon as the child starts trying to remove
> things from memory, we lose the benefits of CoW and USS and PSS rise.

Note that even leaving out the garbage collector, the cPython VM
incrementing/decrementing the refcount of objects will force the copy.

The python multiprocessing module has some classes which allow
explicitly sharing memory.  Certainly for various caches e.g. if
they're just read-only after a certain point it might make sense
to wrap them in e.g. a multiprocessing.Value.




