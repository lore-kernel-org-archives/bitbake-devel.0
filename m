Received: from ra.se.axis.com ([195.60.68.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <olof.johansson@axis.com>) id 1U0Slq-0006Kj-Sl
	for bitbake-devel@lists.openembedded.org;
	Wed, 30 Jan 2013 09:11:56 +0100
Received: from localhost (localhost [127.0.0.1])
	by ra.se.axis.com (Postfix) with ESMTP id 5750F2A38E
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Jan 2013 08:56:07 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at ra.se.axis.com
Received: from ra.se.axis.com ([127.0.0.1])
	by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 2joYtz3Yc7Kb for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Jan 2013 08:56:04 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by ra.se.axis.com (Postfix) with ESMTP id DFF9E2A348
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Jan 2013 08:56:00 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id A1AE1340CA
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Jan 2013 08:56:00 +0100 (CET)
Received: from axis.com (10.92.17.1) by xmail2.se.axis.com (10.0.5.74) with
	Microsoft SMTP Server (TLS) id 8.2.176.0;
	Wed, 30 Jan 2013 08:56:00 +0100
Date: Wed, 30 Jan 2013 08:55:56 +0100
From: Olof Johansson <olof.johansson@axis.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Message-ID: <20130130075555.GA7508@axis.com>
References: <1358759883-7566-1-git-send-email-olof.johansson@axis.com>
	<1359445811-6394-1-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
In-Reply-To: <1359445811-6394-1-git-send-email-olof.johansson@axis.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Subject: Re: [PATCH v2 0/6] fetch2: Updated SFTP fetcher
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
X-List-Received-Date: Wed, 30 Jan 2013 08:13:01 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi,

On 2013-01-29 08:50, Olof Johansson wrote:
> Olof Johansson (6):
>   fetch2: Remove unused code in wget fetcher
>   fetch2: Add a class representing a generic URI
>   fetch2: unittests for bb.fetch2.URI class
>   fetch2: Adapt encode/decode url to use URI class
>   fetch2: Add editor modelines for bb.tests.*
>   fetch2: Add SFTP fetcher

One thing I forgot to mention; after speaking with kergoth on IRC
last Friday, we found that there are some performance penelties
in using the URI class instead of encode/decodeurl. I tried to
profile and see if there were any obvious ways to get it down to
the level of the old encode/decodeurl, but nothing obvious.

I did the performance evaluation by running the unittests.

Forking and running the unittests in seperate processes shows no
change:

 http://codepad.org/SYsVsckY

However, running them in a single process with the timeit module
shows a pretty big (proportional) regression:

 http://codepad.org/Vzu7Pqqw

Is this significant? Running the tests 10000, each run creating
three URI objects, takes ~2 seconds.

-- 
Olof Johasnson


