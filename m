Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TYHhJ-0002Yv-Ue for bitbake-devel@lists.openembedded.org;
	Tue, 13 Nov 2012 15:42:42 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qADESkui004572;
	Tue, 13 Nov 2012 14:28:46 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 03956-08; Tue, 13 Nov 2012 14:28:42 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qADESalL004566
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 13 Nov 2012 14:28:38 GMT
Message-ID: <1352816917.24487.130.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: news@christianvolk.net
Date: Tue, 13 Nov 2012 14:28:37 +0000
In-Reply-To: <20121113123509.Horde.cZcPJLuWis5QojBtb0_w6KA@webmail.df.eu>
References: <20121113123509.Horde.cZcPJLuWis5QojBtb0_w6KA@webmail.df.eu>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: BitBake & ClearCase
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
X-List-Received-Date: Tue, 13 Nov 2012 14:42:42 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-11-13 at 12:35 +0100, news@christianvolk.net wrote:
> Dear bitbake-developer-community,
> 
> I just stumbled across a problem and knows of no other advice than to  
> write to you here:
> 
> In my company we have to use bitbake in combination with ClearCase (CC).
> Bitbake has some problems with the ClearCase-owned files called  
> ?.copyarea.db?.
> Unfortunately, CC adds such a file to each directory which is under  
> source-control.
> The file is read-only and so the task do_unpack fails with the  
> following error message:
> 
> cp: cannot create regular file  
> `/home/[...]/testability-1.0-r0/./testability_src_gen/.copyarea.db':  
> Permission Denied

I'm a little confused about what the real problem is here. cp should be
able to cope with a file that is marked as read-only. Is this saying the
target already exists and can't be written to? Or is it unable to read
from the source? Is the source locked?

Worst case you can implement a custom "unpack" function for your
clearcase fetcher like git does and in there, exclude the problematic
files.

Cheers,

Richard




