Return-Path: <tanuk@iki.fi>
X-Greylist: delayed 444 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 01 Mar 2016 12:57:54 UTC
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27])
	by mail.openembedded.org (Postfix) with ESMTP id 4C7FE6AC3C
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 Mar 2016 12:57:54 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 0AAA0213BD
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 Mar 2016 07:50:31 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
	by compute5.internal (MEProxy); Tue, 01 Mar 2016 07:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=ng7rFhDJ6pkQIgx76eG4UDPzveM=; b=KWaTE
	/u866iVVEjAndDadXECM7ynZSY3m/LR21y/MHAbEqNaBuYpRMBZVLgWntSkmCkNv
	ddp+r2kNuou2/pL0BEUcj+v3jUq4WP4wsq7qkQnoTOskSEF3mincKwgJTDUlS9di
	n7r3qYzhbo+v2pILGsIIiSXpIWpWhuD/gKQu4w=
X-Sasl-enc: HHfjySKKOSOT9Ai53iynXlihGtGYw13ie7TjDKHrNfbg 1456836630
Received: from laptop (a88-113-211-72.elisa-laajakaista.fi [88.113.211.72])
	by mail.messagingengine.com (Postfix) with ESMTPA id 8CC91C0001B
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 Mar 2016 07:50:30 -0500 (EST)
Message-ID: <1456836629.1737.41.camel@iki.fi>
From: Tanu Kaskinen <tanuk@iki.fi>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 01 Mar 2016 14:50:29 +0200
X-Mailer: Evolution 3.18.3-1 
Mime-Version: 1.0
Subject: Triggering graceful bitbake shutdown
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
X-List-Received-Date: Tue, 01 Mar 2016 12:57:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi,

I wrote a small script that runs bitbake sequentially with multiple
MACHINE values. Sometimes I want to stop it with ctrl-c before it has
finished, but it didn't work properly out-of-the box when running
bitbake under the script (my script would not wait for bitbake to exit,
and bitbake threw some backtrace too). I then modified SIGINT handling
in my script so that it forwards the signal to bitbake and then waits
for bitbake to exit. The problem is that bitbake ignores SIGINT. The UI
handles python's KeyboardInterrupt exception, but that exception
doesn't get raised when bitbake runs under my script. I don't know what
triggers KeyboardInterrupt in normal conditions, since SIGINT doesn't
seem to be sufficient, does python perhaps monitor stdin to catch the
actual ctrl-c keypress?

Anyway, sending SIGTERM instead of SIGINT "works". However, the SIGTERM
handler shuts down bitbake immediately rather than waiting for the
current tasks to finish. Is that less safe than the normal ctrl-c
handling? If the immediate shutdown is equally safe, then I have no
problem, but if SIGTERM can cause state corruption so that resuming
later doesn't work reliably, then I'd like to have some way for
triggering graceful bitbake shutdown from my script. Any suggestions?

Or maybe there is already some way to run bitbake for multiple
MACHINEs, and I don't need to write any script myself?

-- 
Tanu

