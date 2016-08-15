Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 2DDB0734B8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 20:28:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7FKSG0K019509; Mon, 15 Aug 2016 21:28:16 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ZG0xZrDlfTxb; Mon, 15 Aug 2016 21:28:16 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7FKSFfC019501
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 15 Aug 2016 21:28:16 +0100
Message-ID: <1471292894.20391.105.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <clarson@kergoth.com>
Date: Mon, 15 Aug 2016 21:28:14 +0100
In-Reply-To: <CABcZANkPs9Y=4Xq9jWRJf8=bhqYM8DE=uv3KjwNckqavUt8G0w@mail.gmail.com>
References: <1471280561.20391.98.camel@linuxfoundation.org>
	<CABcZANkPs9Y=4Xq9jWRJf8=bhqYM8DE=uv3KjwNckqavUt8G0w@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cache: Split Cache() into a NoCache() parent object
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
X-List-Received-Date: Mon, 15 Aug 2016 20:28:20 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2016-08-15 at 10:20 -0700, Christopher Larson wrote:
> 
> On Mon, Aug 15, 2016 at 10:02 AM, Richard Purdie <
> richard.purdie@linuxfoundation.org> wrote:
> > There are some cases we want to parse recipes without any cache
> > setup or involvement. Split out the standalone functions into
> > a NoCache variant which the Cache is based upon, setting the scene
> > for further cleanup and restructuring.
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > 
> > diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
> > index 7118c83..8c1fe11 100644
> > --- a/bitbake/lib/bb/cache.py
> > +++ b/bitbake/lib/bb/cache.py
> > @@ -265,12 +265,68 @@ def realfn2virtual(realfn, cls):
> >          return realfn
> >      return "virtual:" + cls + ":" + realfn
> > 
> > -class Cache(object):
> > +class NoCache(object):
> > +
> > +    def __init__(self, databuilder):
> > +        self.databuilder = databuilder
> > +        self.data = databuilder.data
> > 
> I like the idea, but do we really need to pass in databuilder and set
> data if this class makes no use of it? It's all class methods, after
> all.

If I remember correctly it is used by users of the class, e.g. in
bitbake-worker so this is setting things up for later changes.

data is set since we have a ton of code which knows about this
namespace and I didn't really want to go and patch it all right now.

Cheers,

Richard




