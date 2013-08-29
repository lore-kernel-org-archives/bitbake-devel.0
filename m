Return-Path: <pab@pabigot.com>
Received: from m1plsmtpa01-05.prod.mesa1.secureserver.net
	(m1plsmtpa01-05.prod.mesa1.secureserver.net [64.202.165.10])
	by mail.openembedded.org (Postfix) with ESMTP id 1B3D86BEB1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Aug 2013 17:07:00 +0000 (UTC)
Received: from [192.168.65.10] ([66.41.60.82])
	by m1plsmtpa01-05.prod.mesa1.secureserver.net with 
	id Jh6y1m0071mTNtu01h6yHx; Thu, 29 Aug 2013 10:07:00 -0700
Message-ID: <521F7FB2.4030609@pabigot.com>
Date: Thu, 29 Aug 2013 12:06:58 -0500
From: "Peter A. Bigot" <pab@pabigot.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:17.0) Gecko/20130804 Thunderbird/17.0.8
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <1377695062-16111-1-git-send-email-pab@pabigot.com>
	<521DFDAE.5040507@windriver.com> <521E025B.7070308@pabigot.com>
	<1377783495.1059.4.camel@ted>
In-Reply-To: <1377783495.1059.4.camel@ted>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake: server/xmlrpc/prserv: Increase timeout to default xmlrpc server
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
X-List-Received-Date: Thu, 29 Aug 2013 17:07:01 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/29/2013 08:38 AM, Richard Purdie wrote:
> On Wed, 2013-08-28 at 08:59 -0500, Peter A. Bigot wrote:
>> On 08/28/2013 08:39 AM, Jason Wessel wrote:
>>> On 08/28/2013 08:04 AM, Peter A. Bigot wrote:
>>>> On a heavily-loaded host with local PR server the default 5 second timeout
>>>> produces too-frequent errors:
>>>>
>>>>     ERROR: Can NOT get PRAUTO, exception timed out
>>>>     ERROR: Function failed: package_get_auto_pr
>>>>
>>>> Since this error aborts the build a generous timeout seems appropriate.
>>>>
>>>> Signed-off-by: Peter A. Bigot <pab@pabigot.com>
>>>> ---
>>>>    lib/bb/server/xmlrpc.py | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
>>>> index 4dee5d9..bb87fd7 100644
>>>> --- a/lib/bb/server/xmlrpc.py
>>>> +++ b/lib/bb/server/xmlrpc.py
>>>> @@ -78,7 +78,7 @@ class BBTransport(xmlrpclib.Transport):
>>>>                h.putheader("Bitbake-token", self.connection_token)
>>>>            xmlrpclib.Transport.send_content(self, h, body)
>>>>    
>>>> -def _create_server(host, port, timeout = 5):
>>>> +def _create_server(host, port, timeout = 20):
>>>>        t = BBTransport(timeout)
>>>>        s = xmlrpclib.Server("http://%s:%d/" % (host, port), transport=t, allow_none=True)
>>>>        return s, t
>>> I would go so far as to make this 60 seconds and or have it a configurable parameter.
>>>
>>> Previously the timeout was infinite.   I have observed process creation lagging by 30-45 seconds on a server with a load average of +300.   The new bitbake python code with the reduced timeout is not yet running on our edge case testing environment, but I do expect to hit the same issue.
>> Not sure when the timeout was added, but I believe it was before the
>> modifications in the last few days that moved it to this function; I've
>> been having this problem since switching to poky master.
>>
>> 60 seconds would be fine with me; I could update the patch for that.  A
>> configurable parameter would be better but it wasn't obvious how to do
>> it, so if people prefer that approach I'd rather a bitbake maintainer
>> take over from here.
> The downside is that if something goes wrong this ends up leaving
> bitbake hanging for 60 seconds at exit whilst it tries to connect to a
> server which is never going to exist. I'm rather frustrated that the PR
> service is so slow since this will block the packaging process for that
> length or time.
>
> With that in mind I've radically improved the performance of the server
> with threading. Can people retest with master and see how things behave
> now?
I rebased my poky to include current master which has your multithreaded 
PR server patches from 28 Aug, dropped my patch, and started a 
from-scratch build involving 5971 tasks.  It aborted twice with:

   ERROR: Can NOT get PRAUTO, exception timed out
   ERROR: Function failed: package_get_auto_pr

before it got through the first 1500 tasks.  I put my patch back and it 
ran through the remaining 4400+ tasks without error.

The threading makes sense for a shared PR server serving multiple remote 
clients, but it's not enough for a localhost server that's heavily 
loaded with other work.

Peter

