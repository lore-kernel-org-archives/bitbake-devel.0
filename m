Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QXD4u-0005UD-4h for bitbake-devel@lists.openembedded.org;
	Thu, 16 Jun 2011 15:57:48 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p5GDsKvk009248
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Jun 2011 14:54:20 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 08736-08 for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Jun 2011 14:54:16 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p5GDsDd1009242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Jun 2011 14:54:14 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 16 Jun 2011 14:54:10 +0100
Message-ID: <1308232450.15712.436.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: Couple of nasty bitbake issues
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
X-List-Received-Date: Thu, 16 Jun 2011 13:57:48 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

We have two nasty bitbake issues I've found:

a) Our event handlers don't behave quite as you'd expect due to the use
of global namespace.

Basically, if you *ever* register an eventhandler, even in an optional
class like native or nativesdk, your will always subsequently get called
for any event.

This means a handler in native.bbclass will see parsing events for a
recipe which doesn't use it. The problem comes from ast.py:

    all_handlers = {}
    for var in bb.data.getVar('__BBHANDLERS', d) or []:
        # try to add the handler
        handler = bb.data.getVar(var, d)
        bb.event.register(var, handler)

Since we register the handlers but never un-register them or only call
the ones which the current recipe uses.

I can work around this for now but we really should fix this.

b) The none server is totally broken for logging during parsing. Trying
to cram two combine two pieces of code into one main loop turns out not
to work so well.

The first problem is that any events coming from the sub processes
forked off during parallel parsing don't get sent to the server/UI. I
know this has been commented on by various people, this is the root
cause. I was able to fix that by borrowing queue code from the process
server, so far so good.

The problem then is the logger, since the logger in the UI uses the same
namespace and setup as the one in the server. The one in the server is
supposed to fire() events, the one in the UI is then meant to write them
to the console. Trying to do both things in the same process goes
horribly wrong. I have a hacky fix where each event is just seen twice
but it doesn't look like an easy problem to solve. I'm unable to find an
easy way to setup two loggers in parallel copying the config from one to
the other which is ideally what is needed.

I like the none server as its simple to debug. At present its looking
like it might be too ugly to fix this though. My hacks are:

http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=rpurdie/ml&id=a3a130b3c6ca760066ca830eb46fa472ecb84c88

Cheers,

Richard







