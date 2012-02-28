Received: from mail.dream-property.net ([82.149.226.172])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <obi@opendreambox.org>) id 1S2LkG-0005y7-9v
	for bitbake-devel@lists.openembedded.org;
	Tue, 28 Feb 2012 13:01:28 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail.dream-property.net (Postfix) with ESMTP id BCC9731593E1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Feb 2012 12:52:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.dream-property.net
Received: from mail.dream-property.net ([127.0.0.1])
	by localhost (mail.dream-property.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 1OzrEXqKZKCE for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Feb 2012 12:52:48 +0100 (CET)
Received: from [172.22.22.61] (drms-590c5704.pool.mediaWays.net [89.12.87.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.dream-property.net (Postfix) with ESMTPSA id 1E7D931593AC
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Feb 2012 12:52:48 +0100 (CET)
Message-ID: <4F4CC00F.10608@opendreambox.org>
Date: Tue, 28 Feb 2012 12:52:47 +0100
From: Andreas Oberritter <obi@opendreambox.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
Subject: Git, AUTOREV and SSH
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
X-List-Received-Date: Tue, 28 Feb 2012 12:01:28 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

there's a problem with the Git fetcher when used with AUTOREV, at least
with SSH URIs. "git ls-remote" may output warnings on stderr, e.g.:

X11 forwarding request failed on channel 0

When this happens, "X11" becomes the SRCREV and the fetcher subsequently
fails. Certainly, other warnings by Git, SSH or a different SCM or
transport could appear under other circumstances. Even localized strings
may appear. Fetch2 merges stderr into stdout on purpose [1], so I'm not
sure a proper fix should look like.

Regards,
Andreas

[1] See runfetchcmd() in lib/bb/fetch2/__init__.py


