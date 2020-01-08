Return-Path: <masahiroy@kernel.org>
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
	[210.131.2.82])
	by mail.openembedded.org (Postfix) with ESMTP id 4EB187FA47
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jan 2020 03:15:13 +0000 (UTC)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com
	[209.85.217.42]) (authenticated)
	by conssluserg-03.nifty.com with ESMTP id 0083F7hi015424;
	Wed, 8 Jan 2020 12:15:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 0083F7hi015424
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
	s=dec2015msa; t=1578453308;
	bh=ZFkujfiMNg2w6WsGhPHQE+HytFiVLcyCL812PULJhsE=;
	h=From:Date:Subject:To:Cc:From;
	b=aLhNyJXFj/W8eDqPlapI236XY2UtBwAG8qhe1hfVinS9QqMii4LmESDWAS2ee4RS3
	7usH9j5rbSxUuUqJ6ZuDM3LeMCiBPotomvth5Dgg1NvsuX9AADOKu/jsqS4bR73wX0
	yu1eLd8eAC0RpddeMJbCO8mdYHjg3oaQMqV7in9x4E73U6zIaSP95jXFxhYp38Mf+6
	PXIYttTODGBQx115b47joRdWA3aVf3RAFrJpoMkaxlqtLjoRNsOQHTygbO48htb/Py
	TY1zsYfNxzsCtWR4kAAQzidzigtTIqkc4xQgkuTgTa9q3pBHDtCzDUncQU04PMYFM9
	JB9HK/Si9aoig==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id g15so982314vsf.1;
	Tue, 07 Jan 2020 19:15:07 -0800 (PST)
X-Gm-Message-State: APjAAAWcSxXRNNTau9UTOpUOMkyr2EAy1KA6asxPsP8cg6bgAumqKSn4
	MLEmx5+e09Zy3MqYL7K8uwvxswTFhiGs+/eQKoo=
X-Google-Smtp-Source: APXvYqx8Sk5iPSxg1uWcZRX5RT35rOzs/WkhGYnQztJH7PYKWl/OBkL9zl0VbmR8fPFNN8q6ULSMm/O58MQm77ydobU=
X-Received: by 2002:a05:6102:190:: with SMTP id
	r16mr1455909vsq.215.1578453306644; 
	Tue, 07 Jan 2020 19:15:06 -0800 (PST)
MIME-Version: 1.0
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 8 Jan 2020 12:14:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNATpVF28nWZ1NsOhe7btPs5Gu7eAjsFjz9AuYncLu+EUyg@mail.gmail.com>
Message-ID: <CAK7LNATpVF28nWZ1NsOhe7btPs5Gu7eAjsFjz9AuYncLu+EUyg@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Subject: Question about the behavior and intent of recrdeptask
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
X-List-Received-Date: Wed, 08 Jan 2020 03:15:14 -0000
Content-Type: text/plain; charset="UTF-8"

Hi.

I am trying to understand 'recrdeptask', but
the bitbake manual did not help me
fully understand it.

I hope this question/analysis will be helpful
for other new learners, too.


When I do "bitbake -g -u taskexp core-image-minimal",
I notice core-image-minimal:do_build
depends on the do_build task of a lot of other packages.
I was wondering where such dependencies come from.

I finally found out the code in
openembedded-core/meta/classes/meta.bbclass

  do_build[recrdeptask] = "do_build"

is the one.

core-image.bbclass (eventually) inherits meta.bbclass


I read the "3.10.4. Recursive Dependencies" section of bitbake manual,
but I could not understand how it works.


So, I wrote test code which consists of the following three recipes,
and figured out how the dependency graph is constructed.

------------------(foo.bb  begin)----------------
PN = 'foo'

do_foo1[nostamp] = "1"
do_foo2[nostamp] = "1"
do_build[nostamp] = "1"

python do_foo1() {
    bb.plain("foo.do_foo1");
}

python do_foo2() {
    bb.plain("foo.do_foo2");
}

python do_build() {
    bb.plain("foo.do_build");
}

addtask foo1 before do_foo2
addtask foo2 before do_build
addtask build

# inter-recipe dependency
do_foo1[depends] = "bar:do_bar1"

# recursive dependency
do_build[recrdeptask] = "do_build"
------------------(foo.bb  end)----------------


------------------(bar.bb  begin)--------------
PN = 'bar'

do_bar1[nostamp] = "1"
do_bar2[nostamp] = "1"
do_build[nostamp] = "1"

python do_bar1() {
    bb.plain("bar.do_bar1")
}

python do_bar2() {
    bb.plain("bar.do_bar2")
}

python do_build() {
    bb.plain("bar.do_build")
}

addtask bar1
addtask bar2 before do_build
addtask build

# inter-recipe dependency
do_bar2[depends] = "baz:do_baz2"
--------------------(bar.bb  end)----------------


--------------------(baz.bb  begin)--------------
PN = 'baz'

do_baz1[nostamp] = "1"
do_baz2[nostamp] = "1"
do_build[nostamp] = "1"

python do_baz1() {
    bb.plain("baz.do_baz1")
}

python do_baz2() {
    bb.plain("baz.do_baz2")
}

python do_build() {
    bb.plain("baz.do_build")
}

addtask baz1
addtask baz2
addtask build
-------------------(baz.bb  end)-------------------




The recipe-internal task orders and
the two "depends" flags construct
the following dependency graph.
(please see the figure with a fixed width font)

[Graph1]
baz:do_baz1       baz:do_baz2       baz:do_build
                      |
                      \/
bar:do_bar1       bar:do_bar2  -->  bar:do_build
   |
   \/
foo:do_foo1  -->  foo:do_foo2  -->  foo:do_build



Now, we will add the effect of:
do_build[recrdeptask] = "do_build"


As far as I understand, this works like this:

  If any arbitrary task of a recipe is reachable from
  foo:do_build, bitbake will add the do_build task
  of that recipe to the dependency graph.

bar:do_bar1 is reachable from foo:do_build,
bitbake adds a new dependency:
 bar:do_build -->  foo:do_build


Then we get the following graph:

[Graph2]
baz:do_baz1       baz:do_baz2       baz:do_build
                      |
                      \/
bar:do_bar1       bar:do_bar2  -->  bar:do_build
   |                                    |
   \/                                   \/
foo:do_foo1  -->  foo:do_foo2  -->  foo:do_build




This process continues recursively until we no longer
find a new dependency.


Now baz:do_baz2 is reachable from foo:do_build

So, bitbake adds a new dependency:
 baz:do_build  -->  foo:do_build


The final dependency graph is as follows:

[Graph3]
baz:do_baz1       baz:do_baz2           baz:do_build
                      |                          |
                      \/                         |
bar:do_bar1       bar:do_bar2  --> bar:do_build  |
   |                                    |        |
   \/                                   \/       \/
foo:do_foo1  -->  foo:do_foo2  -->    foo:do_build




Is my understanding correct?

I still do not understand why we need this flag.


[Q1] What is the intent of meta/classes/meta.bbclass ?

   do_build[recrdeptask] = "do_build"

I do not understand why do_build must have completed
before cure-image-*:do_build.

I think do_build is just no-op in most packages.

If someone does important operations in the do_build task,
that seems to be a pretty special case.
We can add explicit dependency where necessary, can't we?


[Q2] What is the background of necessity of 'recrdeptask'?

The behavior of 'recrdepends' looks so complicated to me.
If we perfectly describe the dependency for each pair of tasks
by the usual dependencies,
we can build up the correct dependency graph as a whole, can't we?


For example, assume the situation where we want the
following dependencies.

 [1] core-image-foo  depends on packagegroup-xxx
 [2] packagegroup-xxx depends on app1 and app2


The recursive dependency makes
core-image-foo directly depend on app1 and app2.

However, even without having recrdeptask,
core-image-foo eventually depends on app1 and app2,
via packagegroup-xxx.


I do not see such a feature in Make
because the dependency is recursive by nature.

So, the concept of  "recursive dependency" sounds
somewhat odd to me.

I guess I am missing important use-cases.
I'd like to know the reason why we need recrdeptask.

Thanks.

--
Best Regards
Masahiro Yamada

