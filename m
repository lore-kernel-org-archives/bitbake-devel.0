Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 1E2746FF0E
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Mar 2016 17:59:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u24Hwqfl007489; Fri, 4 Mar 2016 17:58:52 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id w92gaLlbENcg; Fri,  4 Mar 2016 17:58:52 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u24Hwm93007484
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 4 Mar 2016 17:58:49 GMT
Message-ID: <1457114328.2804.53.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Tanu Kaskinen <tanuk@iki.fi>, bitbake-devel@lists.openembedded.org
Date: Fri, 04 Mar 2016 17:58:48 +0000
In-Reply-To: <1456836629.1737.41.camel@iki.fi>
References: <1456836629.1737.41.camel@iki.fi>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
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
X-List-Received-Date: Fri, 04 Mar 2016 17:59:32 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,

On Tue, 2016-03-01 at 14:50 +0200, Tanu Kaskinen wrote:
> I wrote a small script that runs bitbake sequentially with multiple
> MACHINE values. Sometimes I want to stop it with ctrl-c before it has
> finished, but it didn't work properly out-of-the box when running
> bitbake under the script (my script would not wait for bitbake to
> exit,
> and bitbake threw some backtrace too). I then modified SIGINT
> handling
> in my script so that it forwards the signal to bitbake and then waits
> for bitbake to exit. The problem is that bitbake ignores SIGINT. The
> UI
> handles python's KeyboardInterrupt exception, but that exception
> doesn't get raised when bitbake runs under my script. I don't know
> what
> triggers KeyboardInterrupt in normal conditions, since SIGINT doesn't
> seem to be sufficient, does python perhaps monitor stdin to catch the
> actual ctrl-c keypress?
> 
> Anyway, sending SIGTERM instead of SIGINT "works". However, the
> SIGTERM
> handler shuts down bitbake immediately rather than waiting for the
> current tasks to finish. Is that less safe than the normal ctrl-c
> handling? If the immediate shutdown is equally safe, then I have no
> problem, but if SIGTERM can cause state corruption so that resuming
> later doesn't work reliably, then I'd like to have some way for
> triggering graceful bitbake shutdown from my script. Any suggestions?
> 
> Or maybe there is already some way to run bitbake for multiple
> MACHINEs, and I don't need to write any script myself?

I'm curious which bitbake process you're sending SIGINT to. If its the
knotty UI, it should shutdown gracefully. Other pieces of the system
ignore SIGINT since we really want the UI to do it. The behaviour you
mention above sounds suboptimal though.

I'm a bit pushed for time with the release stablisation at the moment
but would love to see if there is something better we can do here...

Cheers,

Richard

