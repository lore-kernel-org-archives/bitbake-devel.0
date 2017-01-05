Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 750FC65C90
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 Jan 2017 14:56:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v05Es9VK023820; Thu, 5 Jan 2017 14:54:09 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id AbzGa9dU4TpB; Thu,  5 Jan 2017 14:54:09 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v05Es75x023817
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 5 Jan 2017 14:54:09 GMT
Message-ID: <1483628047.4367.92.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <joshua.g.lock@linux.intel.com>,
	bitbake-devel@lists.openembedded.org
Date: Thu, 05 Jan 2017 14:54:07 +0000
In-Reply-To: <1483627614.7913.1.camel@linux.intel.com>
References: <1483624327-18607-1-git-send-email-richard.purdie@linuxfoundation.org>
	<1483627614.7913.1.camel@linux.intel.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Subject: Re: [PATCH v2] prserv/serv: Tweak stdout manipulation to be stream safe
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
X-List-Received-Date: Thu, 05 Jan 2017 14:56:13 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2017-01-05 at 14:46 +0000, Joshua Lock wrote:
> On Thu, 2017-01-05 at 13:52 +0000, Richard Purdie wrote:
> > +        # to physically close the fds to prevent the program
> > launching us from
> > +        # potentially hanging on a pipe. Handle both cases.
> >          si = open('/dev/null', 'r')
> > +        try:
> > +            os.dup2(si.fileno(),sys.stdin.fileno())
> > +        except (AttributeError, io.UnsupportedOperation):
> > +            sys.stdin = si
> >          so = open(self.logfile, 'a+')
> > -        se = so
> > -        os.dup2(si.fileno(),sys.stdin.fileno())
> > -        os.dup2(so.fileno(),sys.stdout.fileno())
> > -        os.dup2(se.fileno(),sys.stderr.fileno())
> > +        try:
> > +            os.dup2(so.fileno(),sys.stdout.fileno())
> > +        except (AttributeError, io.UnsupportedOperation):
> > +            sys.stdout = so
> > +        try:
> > +            os.dup2(so.fileno(),sys.stderr.fileno())
> > +        except (AttributeError, io.UnsupportedOperation):
> > +            sys.stderr = so
> I think there's a copy/paste error here — shouldn't the second
> try/except be duplicating/assigning se not so?

so == se in the original code and I dropped that just using so
everywhere here so I believe the code is ok.

Cheers,

Richard

