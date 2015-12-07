Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id D1A5B60124
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Dec 2015 17:37:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tB7HbBVA019069; Mon, 7 Dec 2015 17:37:11 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id h-e5xXzugNtl; Mon,  7 Dec 2015 17:37:11 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tB7Havbl019061
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 7 Dec 2015 17:37:08 GMT
Message-ID: <1449509817.19730.8.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: brian avery <avery.brian@gmail.com>, Ed Bartosh
	<ed.bartosh@linux.intel.com>
Date: Mon, 07 Dec 2015 17:36:57 +0000
In-Reply-To: <3bf6fe429855eb5b4d44e28c7bf832423d2f72cb.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
	<3bf6fe429855eb5b4d44e28c7bf832423d2f72cb.1449078919.git.avery.brian@gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 28/30] command: add CommandStarted event
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
X-List-Received-Date: Mon, 07 Dec 2015 17:37:17 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi Ed,

On Wed, 2015-12-02 at 10:03 -0800, brian avery wrote:
> From: Ed Bartosh <ed.bartosh@linux.intel.com>
> 
> This event will be used by toasterui to set BRBE build parameter
> as soon as it's provided to bitbake server by Toaster.
> 
> Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
> Signed-off-by: brian avery <avery.brian@gmail.com>
> ---
>  lib/bb/command.py | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/lib/bb/command.py b/lib/bb/command.py
> index 74106d1..78ce03a 100644
> --- a/lib/bb/command.py
> +++ b/lib/bb/command.py
> @@ -31,6 +31,11 @@ Commands are queued in a CommandQueue
>  import bb.event
>  import bb.cooker
>  
> +class CommandStarted(bb.event.Event):
> +    def  __init__(self, commandline):
> +        bb.event.Event.__init__(self)
> +        self.commandline = commandline
> +
>  class CommandCompleted(bb.event.Event):
>      pass
>  
> @@ -60,6 +65,7 @@ class Command:
>          self.currentAsyncCommand = None
>  
>      def runCommand(self, commandline, ro_only = False):
> +        bb.event.fire(CommandStarted(commandline), self.cooker.expanded_data)
>          command = commandline.pop(0)
>          if hasattr(CommandsSync, command):
>              # Can run synchronous commands straight away

I'm not sure I like the idea of this, particularly after I've seen what
you're using it to do. Just from a performance standpoint, adding in an
event per command execution adds in round trips and will increase the
time something simple like "bitbake -p" takes to do nothing when the
cache is hot.

I note in a later patch you use this to check for a command coming from
elsewhere to modify the data store and I worry that we'll end up with
unstructured code if we encourage people to do that too.

I did briefly talk to Brian and he mentioned you needed a way to
differentiate between events from different builds. I'd suggest you can
could do this if you markup the events as they come through your event
receiver, since events for a specific build should come through a
specific socket. Worst case I'd prefer doing this internally to bitbake
rather than the command interception above but adding data to every
event being sent over IPC is something I'd prefer to avoid if we can
too.

Would you be able to see if there is a different way we could handle
this?

Cheers,

Richard




