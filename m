Received: from moutng.kundenserver.de ([212.227.17.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <enrico.scholz@informatik.tu-chemnitz.de>)
	id 1SJ37v-0002yc-E8 for bitbake-devel@lists.openembedded.org;
	Sat, 14 Apr 2012 15:34:55 +0200
Received: from mail.bigo.ensc.de (p54ADDDDF.dip.t-dialin.net [84.173.221.223])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0MCqAt-1SS5SZ1w9L-009dUw; Sat, 14 Apr 2012 15:20:28 +0200
Received: from sheridan.bigo.ensc.de (sheridan.bigo.ensc.de [192.168.46.11])
	by mail.bigo.ensc.de (8.14.4/8.14.4) with ESMTP id q3EDKQXE006966;
	Sat, 14 Apr 2012 15:20:26 +0200
Received: from ensc by sheridan.bigo.ensc.de with local (Exim 4.76)
	(envelope-from <ensc@sheridan.bigo.ensc.de>)
	id 1SJ2tu-000730-Jv; Sat, 14 Apr 2012 15:20:26 +0200
From: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <1334325973-15760-1-git-send-email-enrico.scholz@informatik.tu-chemnitz.de>
	<1334398898.7309.97.camel@ted>
Date: Sat, 14 Apr 2012 15:20:26 +0200
In-Reply-To: <1334398898.7309.97.camel@ted> (Richard Purdie's message of "Sat, 
	14 Apr 2012 11:21:38 +0100")
Message-ID: <87k41ibgbp.fsf@sheridan.bigo.ensc.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
MIME-Version: 1.0
Sender: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
X-Provags-ID: V02:K0:Awao1MyPukrYyYj6/xVtEsJ92G/ggwlcwsIYf+9Y7RY
	4vLttBOqU1A3vaHhMnkSvAvSbUc78d0u6IdUR9NYchhdCbK8rx
	J0in35rWGIF2ayxBxtZyZ9D/tGfpXHIl4JGOakRa2gdUSaDp/t
	hhDNUzCcrykKsXJb8qslR4oUp+SFFiXPgQ8961BAtiipBALRxR
	FhiUfQPhjfqgspIGGKQ5RztWruTfZ78md3zSheclijaG7pGAEY
	Sdrdon6B8BdEEREFYuWBsmkjXlNktA//KwtKz9uxsJRjtVvmyK
	MRvkKf8+1tSJAudDprkMiUHuE8X9dF8uEp6JtZDiBnQUd9diyF
	CVAnUp++uLEtxV7IGUh082hTpYlJ76N0eF4UjMQes
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/3] fetcher: quote filenames given in commands
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
X-List-Received-Date: Sat, 14 Apr 2012 13:34:55 -0000
Content-Type: text/plain; charset=us-ascii

Richard Purdie <richard.purdie@linuxfoundation.org> writes:

>> Filenames were given as-is to shell commands. This causes problems
>> when names contain characters which have a special meaning. 
> ...
> Whilst I understand what you're trying to fix, I'm afraid I don't like
> the patch. I'd prefer to have one way of building these commands, rather
> than two different ones with the shell=isinstance(cmd, basestring)
> check.

ok; one way would be calling of 'pipes.quote()' on every variable
substituting %s.  But that's boring, error prone and makes the code
ugly.

Another way might be to declare every command as a sequence with special
objects for shell operations; e.g.

| class ShellOp:
|     def __init__(self, op):
|         self.op = op
| 
| cmd = ['bunzip2', '-d', file, ShellOp('|'), 'tar', 'xf', '-']

In simple case (no ShellOp objects), sequence will be given directly to
Popen() with shell=False. Else, pipes.quote() will be applied on every
string element of the sequence while ShellOp() objects will be kept as
as-is.


> I'd like to find a cleaner approach that doesn't involve runfetchcmd2.

As I wrote in the comment, runfetchcmd2() exists because ${FETCHCMD}
might be defined as

  git -c 'url.file://${WORKSPACE_DIR}/avrprog.insteadOf=git://git.somewhere/avrprog.git'

There is no simple way to split it into a sequence (note: there might be
quoted whitespaces in an option).



Enrico


