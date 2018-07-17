Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 54EED78862;
	Tue, 17 Jul 2018 12:11:56 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w6HCBsSE024607
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Tue, 17 Jul 2018 13:11:55 +0100
Message-ID: <c90e84ccea269649256438f026bf97cfeb794800.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Watt <jpewhacker@gmail.com>, bitbake-devel@lists.openembedded.org, 
	openembedded-core@lists.openembedded.org
Date: Tue, 17 Jul 2018 13:11:54 +0100
In-Reply-To: <20180716203728.23078-9-JPEWhacker@gmail.com>
References: <20180716203728.23078-1-JPEWhacker@gmail.com>
	<20180716203728.23078-9-JPEWhacker@gmail.com>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.4 at dan
X-Virus-Status: Clean
Subject: Re: [RFC 8/9] hashserver: Add initial reference server
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
X-List-Received-Date: Tue, 17 Jul 2018 12:11:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2018-07-16 at 15:37 -0500, Joshua Watt wrote:
> Adds an initial reference implementation of the hash server.
> 
> NOTE: This is my first dive into HTTP & REST technologies. Feedback
> is
> appreciated. Also, I don't think it will be necessary for this
> reference
> implementation to live in bitbake, and it can be moved to it's own
> independent project if necessary?
> 
> Also, this server has some concurrency issues that I haven't tracked
> down and will occasionally fail to record a new POST'd task with an
> error indicating the database is locked. Based on some reading, I
> believe this is because the server is using a sqlite backend, and it
> would go away with a more production worthy backend. Anyway, it is
> good
> enough for some preliminary testing.
> 
> Starting the server is simple and only requires pipenv to be
> installed:
> 
>  $ pipenv shell
>  $ ./app.py

I need to spend some time digesting this series but this patch did make
me a little sad.

I'm hoping we can make the hash equivalence server something people use
easily and perhaps part of bitbake. The dependencies you've used in
this code mean it has a significantly higher "barrier to use" than most
of our other code though :(

On the one hand I can understand people wanting to use dependencies and
new technology. On the other, keeping things simple also has
advantages.

Even the minimum python version is potentially problematic, we don't
even have working recipes for python 3.6!

I appreciate its a reference and means we can test the rest of the code
 so its good but we may need a different implementation of this
ultimately.

Cheers,

Richard


