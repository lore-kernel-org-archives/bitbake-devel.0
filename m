Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id BD04D6A456
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Jun 2013 12:58:30 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r56D3LFe029225; Thu, 6 Jun 2013 14:03:21 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id z_KbTH40mY_0; Thu,  6 Jun 2013 14:03:21 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r56D3Eo0029207
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Thu, 6 Jun 2013 14:03:16 +0100
Message-ID: <1370523486.4039.72.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alex DAMIAN <alexandru.damian@intel.com>
Date: Thu, 06 Jun 2013 13:58:06 +0100
In-Reply-To: <1369998409-16560-4-git-send-email-alexandru.damian@intel.com>
References: <1369998409-16560-1-git-send-email-alexandru.damian@intel.com>
	<1369998409-16560-4-git-send-email-alexandru.damian@intel.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 4/4] xmlrpc: add support for event-observer-only connection
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 06 Jun 2013 12:58:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2013-05-31 at 12:06 +0100, Alex DAMIAN wrote:
> From: Alexandru DAMIAN <alexandru.damian@intel.com>
> 
> This patch adds support for multiple UI clients acting only as event syncs.
> Summary of changes:
> 
> bitbake: adds support for --observe-only command line parameter
> 
> xmlrpc server: create a Observer-only connection type, and small changes
> to accomodate new incoming parameters
> 
> event queue: add exclusive access to structures for multithreaded
> operation; this is needed by accepting new UI handlers on a different thread
> 
> knotty: support for observer-only connections
> 
> Other minor cosmetic changes to support new parameters to functions were made
> 
> Based on original patch by Bogdan Marinescu <bogdan.a.marinescu@intel.com>
> 
> Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> ---
>  bin/bitbake             |  8 ++++++-
>  lib/bb/event.py         | 63 ++++++++++++++++++++++++++++++++++---------------
>  lib/bb/server/xmlrpc.py | 57 +++++++++++++++++++++++++++++++++++++-------
>  lib/bb/ui/knotty.py     | 29 +++++++++++++----------
>  lib/bb/ui/uievent.py    |  4 ++--
>  5 files changed, 119 insertions(+), 42 deletions(-)

I merged the other three patches in the series. I was not happy with the
commit message summary as "XXX: fixes for XXX" tells me nothing. In this
case I rewrote them as examples of what looks better but please think
about those a bit more in future.

For this patch I have some concerns.

> diff --git a/bin/bitbake b/bin/bitbake
> index d263cbd..ef0c5d8 100755
> --- a/bin/bitbake
> +++ b/bin/bitbake
> @@ -197,6 +197,9 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
>          parser.add_option("", "--remote-server", help = "Connect to the specified server",
>                     action = "store", dest = "remote_server", default = False)
>  
> +        parser.add_option("", "--observe-only", help = "Connect to a server as an observing-only client",
> +                   action = "store_true", dest = "observe_only", default = False)
> +
>          options, targets = parser.parse_args(sys.argv)
>          return options, targets[1:]
>  
> @@ -269,6 +272,9 @@ def main():
>      if configParams.remote_server and configParams.servertype != "xmlrpc":
>          sys.exit("FATAL: If '--remote-server' is defined, we must set the servertype as 'xmlrpc'.\n")
>  
> +    if configParams.observe_only and (not configParams.remote_server or configParams.bind):
> +        sys.exit("FATAL: '--observe-only' can only be used by UI clients connecting to a server.\n")
> +
>      if "BBDEBUG" in os.environ:
>          level = int(os.environ["BBDEBUG"])
>          if level > configuration.debug:
> @@ -295,7 +301,7 @@ def main():
>          server = start_server(servermodule, configParams, configuration)
>      else:
>          # we start a stub server that is actually a XMLRPClient to
> -        server = servermodule.BitBakeXMLRPCClient()
> +        server = servermodule.BitBakeXMLRPCClient(configParams.observe_only)
>          server.saveConnectionDetails(configParams.remote_server)


Do we really need a commandline option for this or is this something the
UIs can figure out and do for themselves?

>      logger.removeHandler(handler)
> diff --git a/lib/bb/event.py b/lib/bb/event.py
> index 2826e35..726d074 100644
> --- a/lib/bb/event.py
> +++ b/lib/bb/event.py
> @@ -33,12 +33,15 @@ import atexit
>  import traceback
>  import bb.utils
>  import bb.compat
> +import threading

I've already mentioned that mixing mutliprocessing and threading in
bitbake has been known to cause problems. Did you investigate those
issues and do we know this is safe here?

I actually don't even understand why we're locking this. Only the server
process should be able to touching this queue.

>  # This is the pid for which we should generate the event. This is set when
>  # the runqueue forks off.
>  worker_pid = 0
>  worker_pipe = None
>  
> +_ui_handlers_lock = threading.Lock()
> +
>  logger = logging.getLogger('BitBake.Event')
>  
>  class Event(object):
> @@ -93,6 +96,8 @@ def fire_class_handlers(event, d):
>              continue
>  
>  ui_queue = []
> +_ui_event_history = []
> +_ui_event_history_lock = threading.Lock()
>  @atexit.register
>  def print_ui_queue():
>      """If we're exiting before a UI has been spawned, display any queued
> @@ -124,22 +129,34 @@ def fire_ui_handlers(event, d):
>          # No UI handlers registered yet, queue up the messages
>          ui_queue.append(event)
>          return
> -
> +    _ui_event_history_lock.acquire()
> +    _ui_event_history.append(event)
> +    _ui_event_history_lock.release()
>      errors = []
> -    for h in _ui_handlers:
> -        #print "Sending event %s" % event
> -        try:
> -             # We use pickle here since it better handles object instances
> -             # which xmlrpc's marshaller does not. Events *must* be serializable
> -             # by pickle.
> -             if hasattr(_ui_handlers[h].event, "sendpickle"):
> -                _ui_handlers[h].event.sendpickle((pickle.dumps(event)))
> -             else:
> -                _ui_handlers[h].event.send(event)
> -        except:
> -            errors.append(h)
> -    for h in errors:
> -        del _ui_handlers[h]
> +    _ui_handlers_lock.acquire()
> +    try:
> +        for h in _ui_handlers:
> +            #print "Sending event %s" % event
> +            try:
> +                 # We use pickle here since it better handles object instances
> +                 # which xmlrpc's marshaller does not. Events *must* be serializable
> +                 # by pickle.
> +                 if hasattr(_ui_handlers[h].event, "sendpickle"):
> +                    _ui_handlers[h].event.sendpickle((pickle.dumps(event)))
> +                 else:
> +                    _ui_handlers[h].event.send(event)
> +            except:
> +                errors.append(h)
> +        for h in errors:
> +            del _ui_handlers[h]
> +    finally:
> +        _ui_handlers_lock.release()
> +
> +def get_event_history():
> +    _ui_event_history_lock.acquire()
> +    evt_copy = _ui_event_history[:]
> +    _ui_event_history_lock.release()
> +    return evt_copy


I'm afraid I don't like this at all. Why do we need to keep event
history? Surely the UIs are meant to query the server for current state,
not rely on a reply of existing events?

Reading the code I can figure out what you're doing and why and answer
my own questions. The commit message however sucks as it doesn't tell me
any of this. The locking and so on also looks inappropriate and
worrisome.

So this patch needs some further thought/work.

Cheers,

Richard


