Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 131576BE96
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Sep 2013 16:50:05 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r89H3R6p018230; Mon, 9 Sep 2013 18:03:27 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3a8psgY7Uca2; Mon,  9 Sep 2013 18:03:27 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r89H3OfX018214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 9 Sep 2013 18:03:26 +0100
Message-ID: <1378745386.3484.143.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alex DAMIAN <alexandru.damian@intel.com>
Date: Mon, 09 Sep 2013 17:49:46 +0100
In-Reply-To: <57e230f40897c8ce63ccd4056f56747d64235788.1378743829.git.alexandru.damian@intel.com>
References: <ea491a92f917fa72be06c5e897dc3a55045e776e.1378743829.git.alexandru.damian@intel.com>
	<57e230f40897c8ce63ccd4056f56747d64235788.1378743829.git.alexandru.damian@intel.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 09/13] bitbake: event: do not abort on UI handlers error
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
X-List-Received-Date: Mon, 09 Sep 2013 16:50:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2013-09-09 at 17:41 +0100, Alex DAMIAN wrote:
> From: Alexandru DAMIAN <alexandru.damian@intel.com>
> 
> Ignore runtime errors if UI handlers do something
> funny, as exiting while the loop is running.

This does look rather strange to me. How can a handler exit within the
loop? The handler is either another process or something we're using an
xmlrpc call too. Fine, the other end can disappear but our local end
(and entry in _ui_handlers) should exist until we remove it ourselves?

Only the server itself can do the removal and the server is single
threaded?

Cheers,

Richard




> This allows the builder to continue even if something
> happens to the UI handlers, useful for remote bitbake
> server.
> 
> Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> ---
>  bitbake/lib/bb/event.py | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
> index 67cfcea..1258471 100644
> --- a/bitbake/lib/bb/event.py
> +++ b/bitbake/lib/bb/event.py
> @@ -133,20 +133,24 @@ def fire_ui_handlers(event, d):
>          return
>  
>      errors = []
> -    for h in _ui_handlers:
> -        #print "Sending event %s" % event
> -        try:
> -             if not _ui_logfilters[h].filter(event):
> -                 continue
> -             # We use pickle here since it better handles object instances
> -             # which xmlrpc's marshaller does not. Events *must* be serializable
> -             # by pickle.
> -             if hasattr(_ui_handlers[h].event, "sendpickle"):
> -                _ui_handlers[h].event.sendpickle((pickle.dumps(event)))
> -             else:
> -                _ui_handlers[h].event.send(event)
> -        except:
> -            errors.append(h)
> +    try:
> +        for h in _ui_handlers:
> +            #print "Sending event %s" % event
> +            try:
> +                if not _ui_logfilters[h].filter(event):
> +                    continue
> +                # We use pickle here since it better handles object instances
> +                # which xmlrpc's marshaller does not. Events *must* be serializable
> +                # by pickle.
> +                if hasattr(_ui_handlers[h].event, "sendpickle"):
> +                    _ui_handlers[h].event.sendpickle((pickle.dumps(event)))
> +                else:
> +                    _ui_handlers[h].event.send(event)
> +            except:
> +                errors.append(h)
> +    except RuntimeError:     # may happen that the ui handler simple disappears :D
> +        errors.append(h)
> +
>      for h in errors:
>          del _ui_handlers[h]
>  



