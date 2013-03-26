Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1UKXtt-0000k0-K5; Tue, 26 Mar 2013 18:43:17 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r2QHZ0WN030835; Tue, 26 Mar 2013 17:35:59 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id MSXWD+y8XhjB; Tue, 26 Mar 2013 17:35:59 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r2QHZqbf030865
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Tue, 26 Mar 2013 17:35:55 GMT
Message-ID: <1364318755.3097.106.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto <yocto@yoctoproject.org>, openembedded-core
	<openembedded-core@lists.openembedded.org>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>, "poky@yoctoproject.org"
	<poky@yoctoproject.org>
Date: Tue, 26 Mar 2013 17:25:55 +0000
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Subject: Status updates going forward and communication
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
X-List-Received-Date: Tue, 26 Mar 2013 17:43:21 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

There have been some concerns raised at the TSC recently about how
transparent the Yocto Project development process is and how and where
it connects to OpenEmbedded. When you're dealing with companies and
engineers there does need to be a process with things like schedules and
in the interests of transparency, all the gory details are out there.
This is why you see some things being targeted for milestones and hence
getting more attention than others at certain times. This isn't to say
community input is any less valuable, there is just a balancing act I
need to do to keep all the various areas on track. We don't always keep
the schedules either, I've caused my share of friction by "refusing" to
merge systemd on time several times over for example as it simply hasn't
been ready.

Talking with the TSC, its felt we need to better communicate some of the
issues and what exactly is happening at any given time. I suspect some
of the tension could be helped with some kind of regular status email
about what is going on and where things are at. This would attempt to
explain why patches were slow to merge for example of why certain things
appear to being "ignored" (e.g. the systemd version upgrade is simply
being postponed until after Ross' series merges which in turn is pending
a known bug getting fixed).

From a load perspective, I want to write these summaries like I want a
hole in the head, its going to eat more time which I simply don't have.
The alternatives like asking someone else to write it would likely end
up increasing my workload anyhow though and its certainly true that I
have some of the key information which needs to go into this. I already
explain this several times over each week in different forums but sadly
its not reaching everyone, particularly some of the people it needs to.

I am therefore going to attempt to send out such an email. This is a
trial for now and probably going to be a lot of work for me so let
me/TSC/Jefro/the list know your thoughts on it. I'd love to come up with
a way to get other people involved in the process but I'm simply not
seeing it at the moment. I may try and cut back in my involvement in
some of the other meetings as a consequence though.

Cheers,

Richard



