Received: from mail.dream-property.net ([82.149.226.172])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <obi@opendreambox.org>) id 1S7vz9-0006Uq-Gg
	for bitbake-devel@lists.openembedded.org;
	Wed, 14 Mar 2012 22:43:55 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail.dream-property.net (Postfix) with ESMTP id D8457315A174
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Mar 2012 22:35:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.dream-property.net
Received: from mail.dream-property.net ([127.0.0.1])
	by localhost (mail.dream-property.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id KMte8NWfzMBv for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Mar 2012 22:35:01 +0100 (CET)
Received: from [172.22.22.61] (drms-590ecefe.pool.mediaWays.net
	[89.14.206.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.dream-property.net (Postfix) with ESMTPSA id 08659315A172
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Mar 2012 22:35:00 +0100 (CET)
Message-ID: <4F610F03.1070201@opendreambox.org>
Date: Wed, 14 Mar 2012 22:34:59 +0100
From: Andreas Oberritter <obi@opendreambox.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
Subject: PREFERRED_VERSION and wildcards
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
X-List-Received-Date: Wed, 14 Mar 2012 21:43:55 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I just tried using wildcards, like it's done for gcc, e.g.:

PREFERRED_VERSION_foo = "1.2%"

Now, if I have two foo recipes, foo_1.2.1.bb and foo_1.2.3.bb, in the
same directory, then Bitbake always chooses 1.2.1 instead of the one
with the higher version number. Does bitbake always choose the first
matching version it can find? Is this a general limitation of wildcards,
or is this a problem that can get corrected? I'd expect it to choose the
highest matching version.

Regards,
Andreas


