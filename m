Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TsKeL-0007xp-NU for bitbake-devel@lists.openembedded.org;
	Mon, 07 Jan 2013 22:54:31 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r07LdAli014271;
	Mon, 7 Jan 2013 21:39:10 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 04131-07; Mon,  7 Jan 2013 21:39:06 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r07Ld1t5014254
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 7 Jan 2013 21:39:03 GMT
Message-ID: <1357594743.25855.46.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Biao <huanmateme@163.com>
Date: Mon, 07 Jan 2013 21:39:03 +0000
In-Reply-To: <45483db.6a2c.13bbc028c57.Coremail.huanmateme@163.com>
References: <45483db.6a2c.13bbc028c57.Coremail.huanmateme@163.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-dev <bitbake-devel@lists.openembedded.org>
Subject: Re: Where does the python print goes?
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
X-List-Received-Date: Mon, 07 Jan 2013 21:54:42 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-12-21 at 13:49 +0800, Biao wrote:
> Hi All,
> 
> 
> I have a task in a dum.bb file, after running the task with -vDDD, i
> can not find where the "I am the python output" goes, it is not in the
> terminal, not in the log file. Where does the sys.__stdout__.write
> output to?
> 
> 
> /*----code snap begins---*/
> python do_dm2 () {
>         import sys
>         sys.__stdout__.write("I am the python output\n")
> }
> addtask dm2
> /*----code snap ends---*/

Logfile in ${T} ?

Cheers,

Richard




