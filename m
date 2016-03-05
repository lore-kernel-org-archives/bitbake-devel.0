Return-Path: <tanuk@iki.fi>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
	[66.111.4.29])
	by mail.openembedded.org (Postfix) with ESMTP id DBBFE731C3
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  5 Mar 2016 14:01:54 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id D50D420915
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  5 Mar 2016 09:01:54 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
	by compute3.internal (MEProxy); Sat, 05 Mar 2016 09:01:54 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=wA6Vsni2RwxnEe3
	BVsHFFi4FLfA=; b=nN77v+PHW4AopnQ6AnREv1xyu95L15ZGNVE7ZnQRLo8qYX2
	Ik0Ld0dV/6lDirc6npKWRWkX8ZSoUTdyTYe4z11M3x52cXmrSG0wF71Eu814XzHl
	o7gfZeBziB8r8o5Xp9bMEf4A3RdtEYT8VFUOFPbCIIRddPQPm1dHa+DU7qbg=
X-Sasl-enc: YgI2iy25+30v3jQ22cLYgWW8ZqViLJsJx8Q2zvaeUbtT 1457186514
Received: from laptop (a88-113-211-72.elisa-laajakaista.fi [88.113.211.72])
	by mail.messagingengine.com (Postfix) with ESMTPA id 3324DC0001A;
	Sat,  5 Mar 2016 09:01:54 -0500 (EST)
Message-ID: <1457186513.11730.124.camel@iki.fi>
From: Tanu Kaskinen <tanuk@iki.fi>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Date: Sat, 05 Mar 2016 16:01:53 +0200
In-Reply-To: <1457176919.11730.101.camel@iki.fi>
References: <1456836629.1737.41.camel@iki.fi>
	<1457114328.2804.53.camel@linuxfoundation.org>
	<1457174505.11730.95.camel@iki.fi> <1457176919.11730.101.camel@iki.fi>
X-Mailer: Evolution 3.18.3-1 
Mime-Version: 1.0
Subject: Re: Triggering graceful bitbake shutdown
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
X-List-Received-Date: Sat, 05 Mar 2016 14:01:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Sat, 2016-03-05 at 13:21 +0200, Tanu Kaskinen wrote:
> Hmm... now I realized that if it's normal for knotty to run in a
> separate process and still get KeyboardInterrupts, there must be some
> difference in how my script spawns bitbake compared to how the "main"
> bitbake process spawns the knotty process. Adding a custom SIGINT
> handler to knotty may still make sense, but that should not be required
> to make this work.

Sorry for the noise. The problem was that I spawned bitbake while
SIGINT was blocked in my script, and that was then inherited by the
child process. I removed the SIGINT block in the parent, and now
bitbake responds to ctrl-c just fine.

-- 
Tanu

