Received: from mail-wi0-f177.google.com ([209.85.212.177])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <aleh.arol@gmail.com>) id 1S67Wl-00039S-Sy
	for bitbake-devel@lists.openembedded.org;
	Fri, 09 Mar 2012 22:39:07 +0100
Received: by wibhj13 with SMTP id hj13so860481wib.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 09 Mar 2012 13:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:reply-to:user-agent:mime-version:to:subject
	:content-type:content-transfer-encoding;
	bh=oBl3WC1eXHuzMcnCK2BzUr7X5cNvvenwD2m/jFWN5l4=;
	b=HUw0C7fdp2AXyw+YVZIFc2Ki6gtZZczUYVGrakv6vtEUxBeaHLNIjZWD9R7qQe42rB
	1Ip7YDSA8cKFygD2EFkWXjNF1qZHdQGApnowYWm1cnNKLleS+KsYSgfhyz23szPVcSYY
	WM0qnFwsWzqILnxDAE484tpOMt03IkGuWs8+MzNrWrk5lqqALyt2BAJ94HcOVQlWRvXb
	iGdpx3ebJgUPbPOWCIDiMrquYlqa9o6s34O3qIc0ldq9OU6hVV+u1chV9YzMzzNi/0iX
	shBD5/dTSfBoJ5gjcmxqrrRX5YKZhnxEYs1u7H0Q55Hcgi8XydjvaK8y2D7rtELQ0Zj0
	SIMg==
Received: by 10.180.83.198 with SMTP id s6mr8258119wiy.8.1331328628308;
	Fri, 09 Mar 2012 13:30:28 -0800 (PST)
Received: from [192.168.0.102] ([87.252.227.5])
	by mx.google.com with ESMTPS id 9sm15666507wid.2.2012.03.09.13.30.27
	(version=TLSv1/SSLv3 cipher=OTHER);
	Fri, 09 Mar 2012 13:30:27 -0800 (PST)
Message-ID: <4F5A7671.4080604@gmail.com>
Date: Sat, 10 Mar 2012 00:30:25 +0300
From: Aleh Arol <aleh.arol@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
Subject: configuration based builds with BB
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
Reply-To: aleh.arol@gmail.com
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 09 Mar 2012 21:39:08 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I'm using BB outside of OE for building pythonogre and its deps from
source(around 15 recipes). I stripped OE's environment to the minimal
subset that works (another goal is to deeply understand OE's
infrastructure) - with no cross compilation and assuming toolchain is
always provided.

Now I'm trying to have builds driven by configuration concept (similar
to the project configuration in MS Visual Studio - e.g. debug, release,
devel, prof and so on). Configuration in my case is renders to just a
set of different compiler flags. so I have a global metadata called
CONFIGURATION which is "devel" by default. And that implies using for
example "-g -O2". After I have all built I'd like to rebuild release
packages and what I did that just made a .conf file per configuration:
cat release.conf -> CONFIGURATION = "release"
cat debug.conf -> CONFIGURATION = "debug"

And then folder's metadata as WORKDIR, STAGEDIR and STAMP are all
depends on currend selected conf - so in my staging dir I get
/release/
	/include
	/lib
	...
	/bin
/devel
	/include
	/lib
	...
	/bin
and so on.

And I run nondevel conf build like: bitbake ... -r ./conf/release.conf
However recipes is cached with bb when I build first time(and stamps of
the tasks of the same recipes are cached as I got from the source - so
the effect I want - change a portion of the stamp dir - is not working)
and I need to do explicit touch ./conf/release.conf to force rebuild
with release.conf influence on the metadata defined.

That a situation... questions:
1) Is there's a true BB way of having config driven builds(I know this
can be weird and maybe I don't understand something in OE environment -
so any explanations will be greatly appreciated)
2) What are setscene tasks - couldn't google anything descriptive. (also
not so much comments in the code)

Thanks in advance.

-- 
Best regards,
Aleh Arol



