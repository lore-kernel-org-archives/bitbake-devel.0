Received: from mail.dream-property.net ([82.149.226.172])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <obi@opendreambox.org>) id 1S157v-000671-Vl
	for bitbake-devel@lists.openembedded.org;
	Sat, 25 Feb 2012 01:04:39 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail.dream-property.net (Postfix) with ESMTP id 3AA3E3159551;
	Sat, 25 Feb 2012 00:47:19 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.dream-property.net
Received: from mail.dream-property.net ([127.0.0.1])
	by localhost (mail.dream-property.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id xMfaqDtQWY3x; Sat, 25 Feb 2012 00:47:12 +0100 (CET)
Received: from [172.22.22.61] (drms-590cf87f.pool.mediaWays.net
	[89.12.248.127])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.dream-property.net (Postfix) with ESMTPSA id 738CD3159550;
	Sat, 25 Feb 2012 00:47:12 +0100 (CET)
Message-ID: <4F48217F.6040406@opendreambox.org>
Date: Sat, 25 Feb 2012 00:47:11 +0100
From: Andreas Oberritter <obi@opendreambox.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
Subject: cache broken in master
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
X-List-Received-Date: Sat, 25 Feb 2012 00:04:40 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

commit 1c1df03a6c4717bfd5faab144c4f8bbfcbae0b57 broke bitbake's
dependency cache for me, i.e. it parses all recipes on every invocation
and always displays "(0 cached, 1269 parsed)". Deleting tmp/cache didn't
help. Reverting this commit restores the functionality.

Regards,
Andreas


