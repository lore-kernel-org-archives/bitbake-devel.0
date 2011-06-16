Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jpuhlman@mvista.com>) id 1QXDss-0006p9-HA
	for bitbake-devel@lists.openembedded.org;
	Thu, 16 Jun 2011 16:49:26 +0200
Received: by pvc30 with SMTP id 30so1223823pvc.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Jun 2011 07:45:58 -0700 (PDT)
Received: by 10.68.46.73 with SMTP id t9mr546086pbm.234.1308235557973;
	Thu, 16 Jun 2011 07:45:57 -0700 (PDT)
Received: from [192.168.1.220] (c-67-187-204-11.hsd1.ca.comcast.net
	[67.187.204.11])
	by mx.google.com with ESMTPS id m9sm956505pbd.71.2011.06.16.07.45.56
	(version=TLSv1/SSLv3 cipher=OTHER);
	Thu, 16 Jun 2011 07:45:57 -0700 (PDT)
Message-ID: <4DFA1721.70701@mvista.com>
Date: Thu, 16 Jun 2011 07:45:53 -0700
From: Jeremy Puhlman <jpuhlman@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US;
	rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
	ThunderBrowse/3.3.5
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <1308232450.15712.436.camel@rex>
In-Reply-To: <1308232450.15712.436.camel@rex>
X-Enigmail-Version: 1.1.1
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Couple of nasty bitbake issues
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
X-List-Received-Date: Thu, 16 Jun 2011 14:49:26 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

> http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=rpurdie/ml&id=a3a130b3c6ca760066ca830eb46fa472ecb84c88

I did a quick build with this and it seems to cover the issue I
mentioned this morning. Ill kick off a more robust build, is there
anything I should be watching out for?

-- 
Jeremy Puhlman
Montavista Sofware, LLC.


