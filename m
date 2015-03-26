Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id DEE436013D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Mar 2015 14:30:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t2QEUSff019693 for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Mar 2015 14:30:28 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ah7HEaIdcfv7 for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Mar 2015 14:30:28 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t2QEUG0u019684
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Mar 2015 14:30:27 GMT
Message-ID: <1427380216.14020.100.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 26 Mar 2015 14:30:16 +0000
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: Key expansion and overrides?
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 26 Mar 2015 14:30:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Two interesting test cases:

OVERIDES = "myoverride"
TESTME = "myoverride"
FOO = "1"
FOO_${TESTME} = "2"

FOO = 1 or 2?

OVERIDES = "myoverride"
TESTME = "myoverride"
FOO = "1 2"
FOO_remove_${TESTME} = "2"

FOO = "1 2" or "1"?

Currently expansion in overrides doesn't work. I discovered this trying
to do:

X_remove_pn-gcc-cross-${TARGET_ARCH} = "Y"

which I do believe is a valid thing to attempt.

There are two ways of fixing this I guess. One is to call expandKeys()
before and after update_data() but I suspect we can still cases which
won't work. The other is to move to a model where overrides are applied
more dynamically and we lose the need for update_data(). There may be
some performance penalty for it.

I'm leaning towards trying to kill off update_data() right now...

Thoughts/comments welcome.

Cheers,

Richard




