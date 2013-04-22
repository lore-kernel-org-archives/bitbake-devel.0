Received: from tygrysek.juszkiewicz.com.pl ([178.33.81.99])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <marcin.juszkiewicz@linaro.org>) id 1UUMaL-000347-HE
	for bitbake-devel@lists.openembedded.org;
	Mon, 22 Apr 2013 21:39:44 +0200
Received: by tygrysek.juszkiewicz.com.pl (Postfix, from userid 65534)
	id 39402D2320; Mon, 22 Apr 2013 21:12:18 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	tygrysek.juszkiewicz.com.pl
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
Received: from [192.168.1.112] (87-206-60-225.dynamic.chello.pl
	[87.206.60.225])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marcin@juszkiewicz.com.pl)
	by tygrysek.juszkiewicz.com.pl (Postfix) with ESMTPSA id 083E9D20DD;
	Mon, 22 Apr 2013 21:11:47 +0200 (CEST)
Message-ID: <51758B94.8010405@linaro.org>
Date: Mon, 22 Apr 2013 21:12:20 +0200
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:17.0) Gecko/20130404 Thunderbird/17.0.5
MIME-Version: 1.0
To: Richard Purdie <rpurdie@rpsys.net>
References: <1366640172.23738.12.camel@ted>
In-Reply-To: <1366640172.23738.12.camel@ted>
X-Enigmail-Version: 1.4.6
X-Mailman-Approved-At: Sun, 28 Apr 2013 23:31:40 +0200
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	openembedded-core <openembedded-core@lists.openembedded.org>
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
X-List-Received-Date: Mon, 22 Apr 2013 19:39:45 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

W dniu 22.04.2013 16:16, Richard Purdie pisze:
> I've been giving some thought to where BitBake needs to go in the 
> future in order to deliver for its users. It started life as a 
> commandline utility and its grown a lot since it was first created.
> I think there are some key decisions that need to be taken to ensure 
> its future growth.

There is one thing which kind of bothers me. "ERROR" message which is
just a warning. Like:

ERROR: libelf is listed in PACKAGES multiple times, this leads to packaging errors.
ERROR: libasm is listed in PACKAGES multiple times, this leads to packaging errors.
ERROR: libdw is listed in PACKAGES multiple times, this leads to packaging errors.
ERROR: libdw-dev is listed in PACKAGES multiple times, this leads to packaging errors.
ERROR: libasm-dev is listed in PACKAGES multiple times, this leads to packaging errors.
ERROR: libelf-dev is listed in PACKAGES multiple times, this leads to packaging errors.

If it is error then let BitBake exit instead of doing task. If it is
not error but just a warning then let it be renamed?

My recent build failed with:

--------
NOTE: recipe linaro-image-minimal-1.0-r0: task do_rm_work_all: Started
NOTE: recipe linaro-image-minimal-1.0-r0: task do_rm_work_all: Succeeded
NOTE: Tasks Summary: Attempted 2247 tasks of which 915 didn't need to be rerun and all succeeded.

Summary: There were 3 WARNING messages shown.
Summary: There were 6 ERROR messages shown, returning a non-zero exit code.
Build step 'Execute shell' marked build as failure
--------

"all succeeded" does not look like a reason to fail a build.


