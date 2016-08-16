Return-Path: <jeremy.rosen@smile.fr>
Received: from idris.smile.fr (idris.smile.fr [91.216.209.19])
	by mail.openembedded.org (Postfix) with ESMTP id 0B8B673232
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Aug 2016 10:38:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by idris.smile.fr (Postfix) with ESMTP id 282C41EE0868;
	Tue, 16 Aug 2016 12:38:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at smile.fr
Received: from idris.smile.fr ([127.0.0.1])
	by localhost (bluemind-mta.prod.vitry.intranet [127.0.0.1])
	(amavisd-new, port 10024)
	with ESMTP id 8hqglYdzmBrA; Tue, 16 Aug 2016 12:38:11 +0200 (CEST)
Received: from [10.1.8.214] (gre92-5-82-237-199-7.fbx.proxad.net
	[82.237.199.7])
	by idris.smile.fr (Postfix) with ESMTPSA id EE2FA1EE0807;
	Tue, 16 Aug 2016 12:38:10 +0200 (CEST)
To: Christopher Larson <clarson@kergoth.com>,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>
References: <1469098538-14867-1-git-send-email-jeremy.rosen@smile.fr>
	<1469098538-14867-2-git-send-email-jeremy.rosen@smile.fr>
	<14c66145ed854a22bac20bcc53769fc1@XBOX02.axis.com>
	<CABcZANnzPGjXXvMqmOiVSG4sTYTk0y5iKRZdpCk9Fg+4DHHqQg@mail.gmail.com>
From: =?UTF-8?B?SsOpcsOpbXkgUm9zZW4=?= <jeremy.rosen@smile.fr>
Message-ID: <11041fd5-2248-53b2-a2aa-ffb75331ed24@smile.fr>
Date: Tue, 16 Aug 2016 12:38:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Firefox/45.0 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <CABcZANnzPGjXXvMqmOiVSG4sTYTk0y5iKRZdpCk9Fg+4DHHqQg@mail.gmail.com>
Cc: =?UTF-8?B?SsOpcsOpbXkgUm9zZW4=?= <jeremy.rosen@openwide.fr>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	=?UTF-8?B?SsOpcsOpbXkgUm9zZW4=?= <jeremy.rosen@enst-bretagne.fr>
Subject: Re: [PATCH 1/1] add a syntax to clear variable
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
X-List-Received-Date: Tue, 16 Aug 2016 10:38:11 -0000
Content-Type: multipart/alternative;
	boundary="------------BBD73FCE606CB213EBA67FB4"

--------------BBD73FCE606CB213EBA67FB4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

As Christopher explained, this is an immediate operation.

I'll look into unit test, I've never looked into this so I'm not sure 
how they work...


On 15/08/2016 16:47, Christopher Larson wrote:
>
> On Mon, Aug 15, 2016 at 7:44 AM, Peter Kjellerstedt 
> <peter.kjellerstedt@axis.com <mailto:peter.kjellerstedt@axis.com>> wrote:
>
>     How will this interact with ?=, ??=, _append and _remove?
>
>     Shouldn't there be unit tests for this? It seems like it can easily
>     break and/or be broken by other changes.
>
>
> It's implemented as an immediate operation, so it'd happen long before 
> ??=, _append, or _remove are applied. ?= is also immediate, so isn't 
> relevant -- ?= before it would do nothing, as the unset would undo it, 
> and ?= after the unset would apply fine.
>
> I think that's the most sane approach for something like this. If you 
> want the operation postponed, you can use anonymous python for that. 
> Agreed re: unit tests, though.
> -- 
> Christopher Larson
> clarson at kergoth dot com
> Founder - BitBake, OpenEmbedded, OpenZaurus
> Maintainer - Tslib
> Senior Software Engineer, Mentor Graphics


--------------BBD73FCE606CB213EBA67FB4
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p>As Christopher explained, this is an immediate operation.</p>
    <p>I'll look into unit test, I've never looked into this so I'm not
      sure how they work...<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 15/08/2016 16:47, Christopher Larson
      wrote:<br>
    </div>
    <blockquote
cite="mid:CABcZANnzPGjXXvMqmOiVSG4sTYTk0y5iKRZdpCk9Fg+4DHHqQg@mail.gmail.com"
      type="cite">
      <div dir="ltr">
        <div class="gmail_extra"><br>
          <div class="gmail_quote">On Mon, Aug 15, 2016 at 7:44 AM,
            Peter Kjellerstedt <span dir="ltr">&lt;<a
                moz-do-not-send="true"
                href="mailto:peter.kjellerstedt@axis.com"
                target="_blank">peter.kjellerstedt@axis.com</a>&gt;</span>
            wrote:<br>
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">
              <div id=":2a6" class="a3s aXjCH m1568ea9f9d3743de">How
                will this interact with ?=, ??=, _append and _remove?<br>
                <br>
                Shouldn't there be unit tests for this? It seems like it
                can easily<br>
                break and/or be broken by other changes.</div>
            </blockquote>
          </div>
          <br>
          It's implemented as an immediate operation, so it'd happen
          long before ??=, _append, or _remove are applied. ?= is also
          immediate, so isn't relevant -- ?= before it would do nothing,
          as the unset would undo it, and ?= after the unset would apply
          fine.</div>
        <div class="gmail_extra"><br>
        </div>
        <div class="gmail_extra">I think that's the most sane approach
          for something like this. If you want the operation postponed,
          you can use anonymous python for that. Agreed re: unit tests,
          though.<br>
          -- <br>
          <div class="gmail_signature" data-smartmail="gmail_signature">Christopher
            Larson<br>
            clarson at kergoth dot com<br>
            Founder - BitBake, OpenEmbedded, OpenZaurus<br>
            Maintainer - Tslib<br>
            Senior Software Engineer, Mentor Graphics</div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------BBD73FCE606CB213EBA67FB4--
