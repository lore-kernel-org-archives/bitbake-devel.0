Received: from mail6.webfaction.com ([74.55.86.74] helo=smtp.webfaction.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <openembedded@mindchasers.com>) id 1TmEaB-0001EV-6g
	for bitbake-devel@lists.openembedded.org;
	Sat, 22 Dec 2012 03:13:11 +0100
Received: from [192.168.1.11] (c-68-46-169-75.hsd1.nj.comcast.net
	[68.46.169.75])
	by smtp.webfaction.com (Postfix) with ESMTP id B755026EF336
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Dec 2012 19:35:55 -0600 (CST)
Message-ID: <50D50E7A.6060201@mindchasers.com>
Date: Fri, 21 Dec 2012 20:35:54 -0500
From: Bob Cochran <openembedded@mindchasers.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To: bitbake-dev <bitbake-devel@lists.openembedded.org>
Subject: executable metadata not supported in bbappend files?
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
X-List-Received-Date: Sat, 22 Dec 2012 02:13:14 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I just noticed that the current bitbake manual states in the "Defining 
executable metadata" section that executable metadata is only supported 
in .bb and .bbclass files, but I find that I can put (at least some 
basic) tasks in .bbappend files, too.

Is this an oversight in the documentation, or are there gotchas adding 
tasks to bbappend files that I haven't come across?  If it's the former, 
I'll submit a patch.

Thanks,

Bob



