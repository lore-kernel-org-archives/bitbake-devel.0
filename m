Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1UUKRn-0006sn-MW
	for bitbake-devel@lists.openembedded.org;
	Mon, 22 Apr 2013 19:22:39 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r3MH4rEQ006458
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 22 Apr 2013 10:04:53 -0700 (PDT)
Received: from [172.25.32.36] (172.25.32.36) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.2.342.3;
	Mon, 22 Apr 2013 10:04:52 -0700
Message-ID: <51756DB3.5000802@windriver.com>
Date: Mon, 22 Apr 2013 12:04:51 -0500
From: Jason Wessel <jason.wessel@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:17.0) Gecko/20130308 Thunderbird/17.0.4
MIME-Version: 1.0
To: Trevor Woerner <twoerner@gmail.com>
References: <1366640172.23738.12.camel@ted>
	<CAHUNapQoJ4kOsEMZ-FB9gcSVQcU0ZcY2EfOOGcAGScvueHXHAw@mail.gmail.com>
In-Reply-To: <CAHUNapQoJ4kOsEMZ-FB9gcSVQcU0ZcY2EfOOGcAGScvueHXHAw@mail.gmail.com>
X-Enigmail-Version: 1.5.1
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [OE-core] BitBake changes in the Yocto Project 1.5 cycle
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
X-List-Received-Date: Mon, 22 Apr 2013 17:22:50 -0000
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On 04/22/2013 11:51 AM, Trevor Woerner wrote:
> On Mon, Apr 22, 2013 at 10:16 AM, Richard Purdie <rpurdie@rpsys.net> wrote:
>> We'd add in some kind of
>> timeout of say 15 minutes so that it would gracefully exit.
> Hopefully this time-out will start at the completion of the most
> recent bitbake command, rather than from its start?


It would be good if it was configurable.   I don't mind leaving and instance running 8 hours for example, so I pay the price once for the project for the day.  Also we will want a way to query the status of the instance that is running and kill it.  If the instance is periodically checking that its local.conf still exists when it is idle, it can shut itself down if the build directory has been removed.   Obviously these things are all in the "nice to have" camp.

Cheers,
Jason.



