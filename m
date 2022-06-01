Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FF9C433EF
	for <webhook@archiver.kernel.org>; Wed,  1 Jun 2022 16:54:04 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web08.456.1654102440932259568
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Jun 2022 09:54:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@axis.com
 header.s=axis-central1 header.b=X6vhAZxo;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1654102441;
  x=1685638441;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=CMvFvdrjiwd9D9/NpY8NS5lWgAM8nwVJyZDEsUeyA1M=;
  b=X6vhAZxo43C0OphKHaJxOgibzvwo0i7ziQquhG9ONt1itvsJxHrGWqFz
   lyQRAJtbXR6D7DJRnjCmrtDod7s10mJSZlt54zi8yUQLBgg4mqrDaNrmP
   aTR6DSf/gu+S8NUrdzyiDgw4GOJ6/ifFkg1ZgV/adKc98VXneKPtaYArA
   nIPlRucF0DZAHUqahtEWPVT+R969EhnRzSOhg24l4z4g7Gdj/WogdxeJ8
   57d8bAoxfK4Wo7/O8WEo6MoB/K1AOvh7pMKZLKusoql7jk6pLVC6/tTGY
   CGoN/mnr1pTy9WbrJQUEn5Afi2gDzgF1sM8X9YtfjRIHizZXNXlZSzIoD
   A==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "Reyna, David" <david.reyna@windriver.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 1/1] bitbake: ncurses version of
 taskexp.py
Thread-Topic: [bitbake-devel] [PATCH 1/1] bitbake: ncurses version of
 taskexp.py
Thread-Index: AQHYcyOL0FEzPXp3TkWayKIoEt776q06yYSg
Date: Wed, 1 Jun 2022 16:53:58 +0000
Message-ID: <272a5c37865549099f7bd088df32f675@axis.com>
References: <cover.1653802954.git.David.Reyna@windriver.com>
 <af83d503f04b2064c8ad0f005fa526185e231619.1653802954.git.David.Reyna@windriver.com>
In-Reply-To: 
 <af83d503f04b2064c8ad0f005fa526185e231619.1653802954.git.David.Reyna@windriver.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.5.60]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Jun 2022 16:54:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13724

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Reyna, David
> Sent: den 29 maj 2022 08:16
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 1/1] bitbake: ncurses version of taskexp.=
py

Please don't prefix the commit subject with "bitbake: ". combo-layer will=20
add that prefix when it cherry-picks the commit to the poky repo.

//Peter
=20
>=20
> From: David Reyna <David.Reyna@windriver.com>
>=20
> * Create an ncurses version of the GTK app "taskexp.py".
> * Add these additional features:
>   - Sort tasks in recipes by their dependency order
>   - Print individual and/or recipe-wide dependencies to a file
>   - Add a wild card filter
>   - Show the target recipes on BOLD
>   - Add a seft-test
>=20
> [YOCTO #14814]
>=20
> Signed-off-by: David Reyna <David.Reyna@windriver.com>
> ---
>  lib/bb/ui/taskexp_tty.py | 1400 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 1400 insertions(+)
>  create mode 100755 bitbake/lib/bb/ui/taskexp_tty.py
>=20
> diff --git a/lib/bb/ui/taskexp_tty.py b/lib/bb/ui/taskexp_tty.py
> new file mode 100755
> index 0000000000..6b08f3ff21
> --- /dev/null
> +++ b/lib/bb/ui/taskexp_tty.py
> @@ -0,0 +1,1400 @@
> +#
> +# BitBake Graphical ncurses-based Dependency Explorer
> +#   * Based on the GTK implementation
> +#   * Intended to run on any Linux host
> +#
> +# Copyright (C) 2007        Ross Burton
> +# Copyright (C) 2007 - 2008 Richard Purdie
> +# Copyright (C) 2022        David Reyna
> +#
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +
> +#
> +# Execution example:
> +#   $ bitbake -g -u taskexp_tty acl zlib
> +#
> +# Self-test example:
> +#   $ TASK_EXP_UNIT_TEST=3D1 bitbake -g -u taskexp_tty zlib acl
> +#   ...
> +#   $ echo $?
> +#   0
> +#   $ TASK_EXP_UNIT_TEST=3D1 bitbake -g -u taskexp_tty zlib acl foo
> +#   ERROR: Nothing PROVIDES 'foo'. Close matches:
> +#   ofono
> +#   $ echo $?
> +#   1
> +#
> +# Features:
> +# * Ncurses is used for the presentation layer. Only the 'curses'
> +#   library is used (none of the extension libraries), plus only
> +#   one main screen is used (no sub-windows)
> +# * Uses the 'generateDepTreeEvent' bitbake event to fetch the
> +#   dynamic dependency data based on passed recipes
> +# * Computes and provides reverse dependencies
> +# * Supports task sorting on:
> +#   (a) Task dependency order within each recipe
> +#   (b) Pure alphabetical order
> +#   (c) Provisions for third sort order (bitbake order?)
> +# * The 'Filter' does a "*string*" wildcard filter on tasks in the
> +#   main window, dynamically re-ordering and re-centering the content
> +# * A 'Print' function exports the selected task or its whole recipe
> +#   task set to the default file "taskdep.txt"
> +# * Supports a progress bar for bitbake loads and file printing
> +# * Line art for box drawing supported, ASCII art an alernative
> +# * No horizontal scrolling support. Selected task's full name
> +#   shown in bottom bar
> +# * Dynamically catches terminals that are (or become) too small
> +# * Exception to insure return to normal terminal on errors
> +# * Debugging support, self test option
> +#
> +
> +import sys
> +import traceback
> +import curses
> +import re
> +import time
> +
> +# Bitbake server support
> +import threading
> +from xmlrpc import client
> +import bb
> +import bb.event
> +
> +# Dependency indexes (depends_model)
> +(TYPE_DEP, TYPE_RDEP) =3D (0, 1)
> +DEPENDS_TYPE =3D 0
> +DEPENDS_TASK =3D 1
> +DEPENDS_DEPS =3D 2
> +# Task indexes (task_list)
> +TASK_NAME =3D 0
> +TASK_PRIMARY =3D 1
> +TASK_SORT_ALPHA =3D 2
> +TASK_SORT_DEPS =3D 3
> +TASK_SORT_BITBAKE =3D 4
> +# Sort options (default is SORT_DEPS)
> +SORT_ALPHA =3D 0
> +SORT_DEPS =3D 1
> +SORT_BITBAKE_ENABLE =3D False # NOTE: future sort
> +SORT_BITBAKE =3D 2
> +sort_model =3D SORT_DEPS
> +# Print options
> +PRINT_MODEL_1 =3D 0
> +PRINT_MODEL_2 =3D 1
> +print_model =3D PRINT_MODEL_2
> +print_file_name =3D "taskdep_print.log"
> +print_file_backup_name =3D "taskdep_print_backup.log"
> +is_printed =3D False
> +is_filter =3D False
> +
> +# Standard (and backup) key mappings
> +CHAR_NUL =3D 0            # Used as self-test nop char
> +CHAR_BS_H =3D 8           # Alternate backspace key
> +CHAR_TAB =3D 9
> +CHAR_RETURN =3D 10
> +CHAR_ESCAPE =3D 27
> +CHAR_UP =3D ord('{')      # Used as self-test ASCII char
> +CHAR_DOWN =3D ord('}')    # Used as self-test ASCII char
> +
> +# Color_pair IDs
> +CURSES_NORMAL =3D 0
> +CURSES_HIGHLIGHT =3D 1
> +CURSES_WARNING =3D 2
> +
> +
> +#################################################
> +### Debugging support
> +###
> +
> +verbose =3D False
> +
> +# Debug: capture intermediate information to a log
> +trace_file =3D 'ncurses.log'
> +try:
> +    # Clean trace per run
> +    os.remove(trace_file)
> +except:
> +    pass
> +def _log(msg):
> +    f1=3Dopen(trace_file, 'a')
> +    f1.write(msg + '\n' )
> +    f1.close()
> +
> +# Debug: message display slow-step through display update issues
> +def alert(msg,screen):
> +    if msg:
> +        screen.addstr(0, 10, '[%-4s]' % msg)
> +        screen.refresh();
> +        curses.napms(2000)
> +    else:
> +        if do_line_art:
> +            for i in range(10, 24):
> +                screen.addch(0, i, curses.ACS_HLINE)
> +        else:
> +            screen.addstr(0, 10, '-' * 14)
> +        screen.refresh();
> +
> +# Debug: display edge conditions on frame movements
> +def debug_frame(nbox_ojb):
> +    if verbose:
> +        nbox_ojb.screen.addstr(0, 50, '[I=3D%2d,O=3D%2d,S=3D%3s,H=3D%2d,=
M=3D%4d]' %
> (
> +            nbox_ojb.cursor_index,
> +            nbox_ojb.cursor_offset,
> +            nbox_ojb.scroll_offset,
> +            nbox_ojb.inside_height,
> +            len(nbox_ojb.task_list),
> +        ))
> +        nbox_ojb.screen.refresh();
> +
> +#
> +# Unit test (assumes that 'quilt-native' is always present)
> +#
> +
> +unit_test =3D os.environ.get('TASK_EXP_UNIT_TEST')
> +unit_test_cmnds=3D[
> +    '# Default selected task in primary box',
> +    'tst_selected=3D<TASK>.do_fetch',
> +    '# Default selected task in deps',
> +    'tst_entry=3D<TAB>',
> +    'tst_selected=3D',
> +    '# Default selected task in rdeps',
> +    'tst_entry=3D<TAB>',
> +    'tst_selected=3D<TASK>.do_prepare_recipe_sysroot',
> +    "# Test 'select' back to primary box",
> +    'tst_entry=3D<CR>',
> +    '#tst_entry=3D<DOWN>',  # optional injected error
> +    'tst_selected=3D<TASK>.do_prepare_recipe_sysroot',
> +    '# Check filter',
> +    'tst_entry=3D/uilt-nativ/',
> +    'tst_selected=3Dquilt-native.do_fetch',
> +    '# Check print',
> +    'tst_entry=3Dp',
> +    'tst_printed=3Dquilt-native.do_fetch',
> +    '#tst_printed=3Dquilt-foo.do_nothing',  # optional injected error
> +    '# Done!',
> +    'tst_entry=3Dq',
> +]
> +unit_test_idx=3D0
> +unit_test_command_chars=3D''
> +unit_test_results=3D[]
> +def unit_test_action(active_package):
> +    global unit_test_idx
> +    global unit_test_command_chars
> +    global unit_test_results
> +    ret =3D CHAR_NUL
> +    if unit_test_command_chars:
> +        ch =3D unit_test_command_chars[0]
> +        unit_test_command_chars =3D unit_test_command_chars[1:]
> +        time.sleep(0.5)
> +        ret =3D ord(ch)
> +    else:
> +        line =3D unit_test_cmnds[unit_test_idx]
> +        unit_test_idx +=3D 1
> +        line =3D re.sub('#.*', '', line).strip()
> +        line =3D line.replace('<TASK>',active_package.primary[0])
> +        line =3D line.replace('<TAB>','\t').replace('<CR>','\n')
> +        line =3D line.replace('<UP>','{').replace('<DOWN>','}')
> +        if not line: line =3D 'nop=3Dnop'
> +        cmnd,value =3D line.split('=3D')
> +        if cmnd =3D=3D 'tst_entry':
> +            unit_test_command_chars =3D value
> +        elif cmnd =3D=3D 'tst_selected':
> +            active_selected =3D active_package.get_selected()
> +            if active_selected !=3D value:
> +                unit_test_results.append("ERROR:SELFTEST:expected '%s'
> but got '%s'" % (value,active_selected))
> +                ret =3D ord('Q')
> +            else:
> +                unit_test_results.append("Pass:SELFTEST:found '%s'" %
> (value))
> +        elif cmnd =3D=3D 'tst_printed':
> +            result =3D os.system('grep %s %s' % (value,print_file_name))
> +            if result:
> +                unit_test_results.append("ERROR:PRINTTEST:expected '%s'
> in '%s'" % (value,print_file_name))
> +                ret =3D ord('Q')
> +            else:
> +                unit_test_results.append("Pass:PRINTTEST:found '%s'" %
> (value))
> +    # Return the action (CHAR_NUL for no action til next round)
> +    return(ret)
> +
> +#################################################
> +### Window frame rendering
> +###
> +### By default, use the normal line art. Since
> +###  these extended characters are not ASCII, one
> +###  must use the ncursus API to render them
> +### The alternate ASCII line art set is optionally
> +###  available via the 'do_line_art' flag
> +
> +# By default, render frames using line art
> +do_line_art =3D True
> +
> +# ASCII render set option
> +CHAR_HBAR =3D '-'
> +CHAR_VBAR =3D '|'
> +CHAR_UL_CORNER =3D '/'
> +CHAR_UR_CORNER =3D '\\'
> +CHAR_LL_CORNER =3D '\\'
> +CHAR_LR_CORNER =3D '/'
> +
> +# Box frame drawing with line-art
> +def line_art_frame(box):
> +    x =3D box.base_x
> +    y =3D box.base_y
> +    w =3D box.width
> +    h =3D box.height + 1
> +
> +    if do_line_art:
> +        for i in range(1, w - 1):
> +            box.screen.addch(y, x + i, curses.ACS_HLINE, box.color)
> +            box.screen.addch(y + h - 1, x + i, curses.ACS_HLINE,
> box.color)
> +        body_line =3D "%s" % (' ' * (w - 2))
> +        for i in range(1, h - 1):
> +            box.screen.addch(y + i, x, curses.ACS_VLINE, box.color)
> +            box.screen.addstr(y + i, x + 1, body_line, box.color)
> +            box.screen.addch(y + i, x + w - 1, curses.ACS_VLINE,
> box.color)
> +        box.screen.addch(y, x, curses.ACS_ULCORNER, box.color)
> +        box.screen.addch(y, x + w - 1, curses.ACS_URCORNER, box.color)
> +        box.screen.addch(y + h - 1, x, curses.ACS_LLCORNER, box.color)
> +        box.screen.addch(y + h - 1, x + w - 1, curses.ACS_LRCORNER,
> box.color)
> +    else:
> +        top_line  =3D "%s%s%s" % (CHAR_UL_CORNER,CHAR_HBAR * (w -
> 2),CHAR_UR_CORNER)
> +        body_line =3D "%s%s%s" % (CHAR_VBAR,' ' * (w - 2),CHAR_VBAR)
> +        bot_line  =3D "%s%s%s" % (CHAR_UR_CORNER,CHAR_HBAR * (w -
> 2),CHAR_UL_CORNER)
> +        tag_line  =3D "%s%s%s" % ('[',CHAR_HBAR * (w - 2),']')
> +        # Top bar
> +        box.screen.addstr(y, x, top_line)
> +        # Middle frame
> +        for i in range(1, (h - 1)):
> +            box.screen.addstr(y+i, x, body_line)
> +        # Bottom bar
> +        box.screen.addstr(y + (h - 1), x, bot_line)
> +
> +# Connect the separate boxes
> +def line_art_fixup(box):
> +    if do_line_art:
> +        box.screen.addch(box.base_y+2, box.base_x, curses.ACS_LTEE,
> box.color)
> +        box.screen.addch(box.base_y+2, box.base_x+box.width-1,
> curses.ACS_RTEE, box.color)
> +
> +
> +#################################################
> +### Ncurses box object : box frame object to display
> +### and manage a sub-window's display elements
> +### using basic ncurses
> +###
> +### Supports:
> +###   * Frame drawing, content (re)drawing
> +###   * Content scrolling via ArrowUp, ArrowDn, PgUp, PgDN,
> +###   * Highlighting for active selected item
> +###   * Content sorting based on selected sort model
> +###
> +
> +class NBox():
> +    def __init__(self, screen, label, primary, base_x, base_y, width,
> height):
> +        # Box description
> +        self.screen =3D screen
> +        self.label =3D label
> +        self.primary =3D primary
> +        self.color =3D curses.color_pair(CURSES_NORMAL)
> +        # Box boundaries
> +        self.base_x =3D base_x
> +        self.base_y =3D base_y
> +        self.width =3D width
> +        self.height =3D height
> +        # Cursor/scroll management
> +        self.cursor_enable =3D False
> +        self.cursor_index =3D 0   # Absolute offset
> +        self.cursor_offset =3D 0  # Frame centric offset
> +        self.scroll_offset =3D 0  # Frame centric offset
> +        # Box specific content
> +        # Format of each entry is
> [package_name,is_primary_recipe,alpha_sort_key,deps_sort_key]
> +        self.task_list =3D []
> +
> +    @property
> +    def inside_width(self):
> +        return(self.width-2)
> +
> +    @property
> +    def inside_height(self):
> +        return(self.height-2)
> +
> +    # Populate the box's content, include the sort mappings and
> is_primary flag
> +    def task_list_append(self,task_name,dep):
> +        task_sort_alpha =3D task_name
> +        task_sort_deps =3D dep.get_dep_sort(task_name)
> +        is_primary =3D False
> +        for primary in self.primary:
> +            if task_name.startswith(primary+'.'):
> +                is_primary =3D True
> +        if SORT_BITBAKE_ENABLE:
> +            task_sort_bitbake =3D dep.get_bb_sort(task_name)
> +
> self.task_list.append([task_name,is_primary,task_sort_alpha,task_sort_dep=
s
> ,task_sort_bitbake])
> +        else:
> +
> self.task_list.append([task_name,is_primary,task_sort_alpha,task_sort_dep=
s
> ])
> +
> +    def reset(self):
> +        self.task_list =3D []
> +        self.cursor_index =3D 0   # Absolute offset
> +        self.cursor_offset =3D 0  # Frame centric offset
> +        self.scroll_offset =3D 0  # Frame centric offset
> +
> +    # Sort the box's content based on the current sort model
> +    def sort(self):
> +        if SORT_ALPHA =3D=3D sort_model:
> +            self.task_list.sort(key =3D lambda x: x[TASK_SORT_ALPHA])
> +        elif SORT_DEPS =3D=3D sort_model:
> +            self.task_list.sort(key =3D lambda x: x[TASK_SORT_DEPS])
> +        elif SORT_BITBAKE =3D=3D sort_model:
> +            self.task_list.sort(key =3D lambda x: x[TASK_SORT_BITBAKE])
> +
> +    # The target package list (to hightlight), from the command line
> +    def set_primary(self,primary):
> +        self.primary =3D primary
> +
> +    # Draw the box's outside frame
> +    def draw_frame(self):
> +        line_art_frame(self)
> +        # Title
> +        self.screen.addstr(self.base_y,
> +            (self.base_x + (self.width//2))-((len(self.label)+2)//2),
> +            '['+self.label+']')
> +        self.screen.refresh()
> +
> +    # Draw the box's inside text content
> +    def redraw(self):
> +        task_list_len =3D len(self.task_list)
> +        # Middle frame
> +        body_line =3D "%s" % (' ' * (self.inside_width-1) )
> +        for i in range(0,self.inside_height+1):
> +            if i < (task_list_len + self.scroll_offset):
> +                str_ctl =3D "%%-%ss" % (self.width-3)
> +                # Safety assert
> +                if (i + self.scroll_offset) >=3D task_list_len:
> +                    alert("REDRAW:%2d,%4d,%4d" %
> (i,self.scroll_offset,task_list_len),self.screen)
> +                    break
> +
> +                task_obj =3D self.task_list[i + self.scroll_offset]
> +                task =3D task_obj[TASK_NAME][:self.inside_width-1]
> +                task_primary =3D task_obj[TASK_PRIMARY]
> +
> +                if task_primary:
> +                    line =3D str_ctl % task[:self.inside_width-1]
> +                    self.screen.addstr(self.base_y+1+i, self.base_x+2,
> line, curses.A_BOLD)
> +                else:
> +                    line =3D str_ctl % task[:self.inside_width-1]
> +                    self.screen.addstr(self.base_y+1+i, self.base_x+2,
> line)
> +            else:
> +                line =3D "%s" % (' ' * (self.inside_width-1) )
> +                self.screen.addstr(self.base_y+1+i, self.base_x+2, line)
> +        self.screen.refresh()
> +
> +    # Show the current selected task over the bottom of the frame
> +    def show_selected(self,selected_task):
> +        if not selected_task:
> +            selected_task =3D self.get_selected()
> +        tag_line   =3D "%s%s%s" % ('[',CHAR_HBAR * (self.width-2),']')
> +        self.screen.addstr(self.base_y + self.height, self.base_x,
> tag_line)
> +        self.screen.addstr(self.base_y + self.height,
> +            (self.base_x + (self.width//2))-((len(selected_task)+2)//2),
> +            '['+selected_task+']')
> +        self.screen.refresh()
> +
> +    # Load box with new table of content
> +    def update_content(self,task_list):
> +        self.task_list =3D task_list
> +        if self.cursor_enable:
> +            cursor_update(turn_on=3DFalse)
> +        self.cursor_index =3D 0
> +        self.cursor_offset =3D 0
> +        self.scroll_offset =3D 0
> +        self.redraw()
> +        if self.cursor_enable:
> +            cursor_update(turn_on=3DTrue)
> +
> +    # Manage the box's highlighted task and blinking cursor character
> +    def cursor_on(self,is_on):
> +        self.cursor_enable =3D is_on
> +        self.cursor_update(is_on)
> +
> +    # High-light the current pointed package, normal for released
> packages
> +    def cursor_update(self,turn_on=3DTrue):
> +        str_ctl =3D "%%-%ss" % (self.inside_width-1)
> +        try:
> +            if len(self.task_list):
> +                task_obj =3D self.task_list[self.cursor_index]
> +                task =3D task_obj[TASK_NAME][:self.inside_width-1]
> +                task_primary =3D task_obj[TASK_PRIMARY]
> +                task_font =3D curses.A_BOLD if task_primary else 0
> +            else:
> +                task =3D ''
> +                task_font =3D 0
> +        except Exception as e:
> +            _log("CURSOR_UPDATE:I=3D%3d,M=3D%3d,L=3D%3d" %
> (self.cursor_index,len(self.task_list),len(self.task_list[TASK_NAME])))
> +            alert("CURSOR_UPDATE:%s" % (e),self.screen)
> +            return
> +        if turn_on:
> +
> self.screen.addstr(self.base_y+1+self.cursor_offset,self.base_x+1,">",
> curses.color_pair(CURSES_HIGHLIGHT) | curses.A_BLINK)
> +
> self.screen.addstr(self.base_y+1+self.cursor_offset,self.base_x+2,str_ctl
> % task, curses.color_pair(CURSES_HIGHLIGHT) | task_font)
> +        else:
> +
> self.screen.addstr(self.base_y+1+self.cursor_offset,self.base_x+1," ")
> +
> self.screen.addstr(self.base_y+1+self.cursor_offset,self.base_x+2,str_ctl
> % task, task_font)
> +
> +    # Down arrow
> +    def line_down(self):
> +        if len(self.task_list) <=3D (self.cursor_index+1):
> +            return
> +        self.cursor_update(turn_on=3DFalse)
> +        self.cursor_index +=3D 1
> +        self.cursor_offset +=3D 1
> +        if self.cursor_offset > (self.inside_height):
> +            self.cursor_offset -=3D 1
> +            self.scroll_offset +=3D 1
> +            self.redraw()
> +        self.cursor_update(turn_on=3DTrue)
> +        debug_frame(self)
> +
> +    # Up arrow
> +    def line_up(self):
> +        if 0 > (self.cursor_index-1):
> +            return
> +        self.cursor_update(turn_on=3DFalse)
> +        self.cursor_index -=3D 1
> +        self.cursor_offset -=3D 1
> +        if self.cursor_offset < 0:
> +            self.cursor_offset +=3D 1
> +            self.scroll_offset -=3D 1
> +            self.redraw()
> +        self.cursor_update(turn_on=3DTrue)
> +        debug_frame(self)
> +
> +    # Page down
> +    def page_down(self):
> +        max_task =3D len(self.task_list)-1
> +        if max_task < self.inside_height:
> +            return
> +        self.cursor_update(turn_on=3DFalse)
> +        self.cursor_index +=3D 10
> +        self.cursor_index =3D min(self.cursor_index,max_task)
> +        self.cursor_offset =3D min(self.inside_height,self.cursor_index)
> +        self.scroll_offset =3D self.cursor_index - self.cursor_offset
> +        self.redraw()
> +        self.cursor_update(turn_on=3DTrue)
> +        debug_frame(self)
> +
> +    # Page up
> +    def page_up(self):
> +        max_task =3D len(self.task_list)-1
> +        if max_task < self.inside_height:
> +            return
> +        self.cursor_update(turn_on=3DFalse)
> +        self.cursor_index -=3D 10
> +        self.cursor_index =3D max(self.cursor_index,0)
> +        self.cursor_offset =3D max(0, self.inside_height - (max_task -
> self.cursor_index))
> +        self.scroll_offset =3D self.cursor_index - self.cursor_offset
> +        self.redraw()
> +        self.cursor_update(turn_on=3DTrue)
> +        debug_frame(self)
> +
> +    # Return the currently selected task name for this box
> +    def get_selected(self):
> +        if self.task_list:
> +            return(self.task_list[self.cursor_index][TASK_NAME])
> +        else:
> +            return('')
> +
> +
> +#################################################
> +### The helper sub-windows
> +###
> +
> +# Show persistent help at the top of the screen
> +class HelpBarView(NBox):
> +    def __init__(self, screen, label, primary, base_x, base_y, width,
> height):
> +        super(HelpBarView, self).__init__(screen, label, primary, base_x=
,
> base_y, width, height)
> +
> +    def show_help(self,show):
> +        self.screen.addstr(self.base_y,self.base_x, "%s" % (' ' *
> self.inside_width))
> +        if show:
> +            help =3D "Help=3D'?' Filter=3D'/' NextBox=3D<Tab> Select=3D<=
Enter>
> Print=3D'p','P' Quit=3D'q'"
> +            bar_size =3D self.inside_width - 5 - len(help)
> +
> self.screen.addstr(self.base_y,self.base_x+((self.inside_width-
> len(help))//2), help)
> +        self.screen.refresh()
> +
> +# Pop up a detailed Help box
> +class HelpBoxView(NBox):
> +    def __init__(self, screen, label, primary, base_x, base_y, width,
> height, dep):
> +        super(HelpBoxView, self).__init__(screen, label, primary, base_x=
,
> base_y, width, height)
> +        self.x_pos =3D 0
> +        self.y_pos =3D 0
> +        self.dep =3D dep
> +
> +    # Instantial the pop-up help box
> +    def show_help(self,show):
> +        self.x_pos =3D self.base_x + 4
> +        self.y_pos =3D self.base_y + 2
> +
> +        def add_line(line):
> +            if line:
> +                self.screen.addstr(self.y_pos,self.x_pos,line)
> +            self.y_pos +=3D 1
> +
> +        # Gather some statisics
> +        dep_count =3D 0
> +        rdep_count =3D 0
> +        for task_obj in self.dep.depends_model:
> +            if TYPE_DEP =3D=3D task_obj[DEPENDS_TYPE]:
> +                dep_count +=3D 1
> +            elif TYPE_RDEP =3D=3D task_obj[DEPENDS_TYPE]:
> +                rdep_count +=3D 1
> +
> +        self.draw_frame()
> +        line_art_fixup(self.dep)
> +        add_line("Quit                : 'q' ")
> +        add_line("Filter task names   : '/'")
> +        add_line("Tab to next box     : <Tab>")
> +        add_line("Select a task       : <Enter>")
> +        add_line("Print task's deps   : 'p'")
> +        add_line("Print recipe's deps : 'P'")
> +        add_line(" -> '%s'" % print_file_name)
> +        add_line("Sort toggle         : 's'")
> +        add_line(" %s Recipe inner-depends order" % ('->' if (SORT_DEPS
> =3D=3D sort_model) else '- '))
> +        add_line(" %s Alpha-numeric order" % ('->' if (SORT_ALPHA =3D=3D
> sort_model) else '- '))
> +        if SORT_BITBAKE_ENABLE:
> +            add_line(" %s Bitbake order" % ('->' if (TASK_SORT_BITBAKE =
=3D=3D
> sort_model) else '- '))
> +        add_line("Alternate backspace : <CTRL-H>")
> +        add_line("")
> +        add_line("Primary recipes =3D %s"  % ','.join(self.primary))
> +        add_line("Task  count     =3D %4d" % len(self.dep.pkg_model))
> +        add_line("Deps  count     =3D %4d" % dep_count)
> +        add_line("RDeps count     =3D %4d" % rdep_count)
> +        add_line("")
> +        self.screen.addstr(self.y_pos,self.x_pos+7,"<Press any key>",
> curses.color_pair(CURSES_HIGHLIGHT))
> +        self.screen.refresh()
> +        c =3D self.screen.getch()
> +
> +# Show a progress bar
> +class ProgressView(NBox):
> +    def __init__(self, screen, label, primary, base_x, base_y, width,
> height):
> +        super(ProgressView, self).__init__(screen, label, primary,
> base_x, base_y, width, height)
> +
> +    def progress(self,title,current,max):
> +        if title:
> +            self.label =3D title
> +        else:
> +            title =3D self.label
> +        if max <=3D0: max =3D 10
> +        bar_size =3D self.width - 7 - len(title)
> +        bar_done =3D int( (float(current)/float(max)) * float(bar_size) =
)
> +        self.screen.addstr(self.base_y,self.base_x, " %s:[%s%s]" %
> (title,'*' * bar_done,' ' * (bar_size-bar_done)))
> +        self.screen.refresh()
> +        return(current+1)
> +
> +    def clear(self):
> +        self.screen.addstr(self.base_y,self.base_x, "%s" % (' ' *
> self.width))
> +        self.screen.refresh()
> +
> +# Implement a task filter bar
> +class FilterView(NBox):
> +    SEARCH_NOP =3D 0
> +    SEARCH_GO =3D 1
> +    SEARCH_CANCEL =3D 2
> +
> +    def __init__(self, screen, label, primary, base_x, base_y, width,
> height):
> +        super(FilterView, self).__init__(screen, label, primary, base_x,
> base_y, width, height)
> +        self.do_show =3D False
> +        self.filter_str =3D ""
> +
> +    def clear(self,enable_show=3DTrue):
> +        self.filter_str =3D ""
> +
> +    def show(self,enable_show=3DTrue):
> +        self.do_show =3D enable_show
> +        if self.do_show:
> +            self.screen.addstr(self.base_y,self.base_x, "[ Filter: %-25s
> ]      '/'=3Dcancel, format=3D'abc'       " % self.filter_str[0:25])
> +        else:
> +            self.screen.addstr(self.base_y,self.base_x, "%s" % (' ' *
> self.width))
> +        self.screen.refresh()
> +
> +    def show_prompt(self):
> +        self.screen.addstr(self.base_y,self.base_x + 10 +
> len(self.filter_str), " ")
> +        self.screen.addstr(self.base_y,self.base_x + 10 +
> len(self.filter_str), "")
> +
> +    # Keys specific to the filter box (start/stop filter keys are in the
> main loop)
> +    def input(self,c,ch):
> +        ret =3D self.SEARCH_GO
> +        if c in (curses.KEY_BACKSPACE,CHAR_BS_H):
> +            #  Backspace
> +            if self.filter_str:
> +                self.filter_str =3D self.filter_str[0:-1]
> +                self.show()
> +        elif ((ch >=3D 'a') and (ch <=3D 'z')) or ((ch >=3D 'A') and (ch=
 <=3D
> 'Z')) or ((ch >=3D '0') and (ch <=3D '9')) or (ch in (' ','_','.','-')):
> +            # The isalnum() acts strangly with keypad(True), so explicit
> bounds
> +            self.filter_str +=3D ch
> +            self.show()
> +        else:
> +            ret =3D self.SEARCH_NOP
> +        return(ret)
> +
> +
> +#################################################
> +### The primary dependency windows
> +###
> +
> +# The main list of package tasks
> +class PackageView(NBox):
> +    def __init__(self, screen, label, primary, base_x, base_y, width,
> height):
> +        super(PackageView, self).__init__(screen, label, primary, base_x=
,
> base_y, width, height)
> +
> +    # Find and verticaly center a selected task (from filter or from
> dependent box)
> +    # The 'task_filter_str' can be a full or a partial (filter) task nam=
e
> +    def find(self,task_filter_str):
> +        found =3D False
> +        max =3D self.height-2
> +        if not task_filter_str:
> +            return(found)
> +        for i,task_obj in enumerate(self.task_list):
> +            task =3D task_obj[TASK_NAME]
> +            if task.startswith(task_filter_str):
> +                self.cursor_on(False)
> +                self.cursor_index =3D i
> +
> +                # Position selected at vertical center
> +                vcenter =3D self.inside_height // 2
> +                if self.cursor_index <=3D vcenter:
> +                    self.scroll_offset =3D 0
> +                    self.cursor_offset =3D self.cursor_index
> +                elif self.cursor_index >=3D (len(self.task_list) - vcent=
er
> - 1):
> +                    self.cursor_offset =3D self.inside_height-1
> +                    self.scroll_offset =3D self.cursor_index -
> self.cursor_offset
> +                else:
> +                    self.cursor_offset =3D vcenter
> +                    self.scroll_offset =3D self.cursor_index -
> self.cursor_offset
> +
> +                self.redraw()
> +                self.cursor_on(True)
> +                found =3D True
> +                break
> +        return(found)
> +
> +# The view of dependent packages
> +class PackageDepView(NBox):
> +    def __init__(self, screen, label, primary, base_x, base_y, width,
> height):
> +        super(PackageDepView, self).__init__(screen, label, primary,
> base_x, base_y, width, height)
> +
> +# The view of reverse-dependent packages
> +class PackageReverseDepView(NBox):
> +    def __init__(self, screen, label, primary, base_x, base_y, width,
> height):
> +        super(PackageReverseDepView, self).__init__(screen, label,
> primary, base_x, base_y, width, height)
> +
> +
> +#################################################
> +### DepExplorer : The parent frame and object
> +###
> +
> +class DepExplorer(NBox):
> +    def __init__(self,screen):
> +        title =3D "Task Dependency Explorer"
> +        super(DepExplorer, self).__init__(screen, 'Task Dependency
> Explorer','',0,0,80,23)
> +
> +        self.pkg_model =3D []
> +        self.depends_model =3D []
> +        self.dep_sort_map =3D {}
> +        self.bb_sort_map =3D {}
> +        self.filter_str =3D ''
> +        self.filter_prev =3D 'deadbeef'
> +
> +        self.help_bar_view =3D HelpBarView(screen, "Help",'',1,1,79,1)
> +        self.help_box_view =3D HelpBoxView(screen,
> "Help",'',0,2,40,20,self)
> +        self.progress_view =3D ProgressView(screen, "Progress",'',2,1,76=
,1)
> +        self.filter_view =3D FilterView(screen, "Filter",'',2,1,76,1)
> +        self.package_view =3D PackageView(screen, "Package",'alpha',
> 0,2,40,20)
> +        self.dep_view =3D PackageDepView(screen,
> "Dependencies",'beta',40,2,40,10)
> +        self.reverse_view =3D PackageReverseDepView(screen, "Dependent
> Tasks",'gamma',40,13,40,9)
> +        self.draw_frames()
> +
> +    # Draw this main window's frame and all sub-windows
> +    def draw_frames(self):
> +        self.draw_frame()
> +        self.package_view.draw_frame()
> +        self.dep_view.draw_frame()
> +        self.reverse_view.draw_frame()
> +        if is_filter:
> +            self.filter_view.show(True)
> +            self.filter_view.show_prompt()
> +        else:
> +            self.help_bar_view.show_help(True)
> +        self.package_view.redraw()
> +        self.dep_view.redraw()
> +        self.reverse_view.redraw()
> +        self.show_selected(self.package_view.get_selected())
> +        line_art_fixup(self)
> +
> +    # Parse the bitbake dependency event object
> +    def parse(self, depgraph):
> +        for task in depgraph["tdepends"]:
> +            self.pkg_model.insert(0, task)
> +            for depend in depgraph["tdepends"][task]:
> +                self.depends_model.insert (0, (TYPE_DEP, task, depend))
> +                self.depends_model.insert (0, (TYPE_RDEP, depend, task))
> +        self.dep_sort_prep()
> +
> +    # Prepare the dependency sort order keys
> +    # This method creates sort keys per recipe tasks in
> +    # the order of each recipe's internal dependecies
> +    # Method:
> +    #   Filter the tasks in dep order in dep_sort_map =3D {}
> +    #   (a) Find a task that has no dependecies
> +    #       Ignore non-recipe specific tasks
> +    #   (b) Add it to the sort mapping dict with
> +    #       key of "<task_group>_<order>"
> +    #   (c) Remove it as a dependency from the other tasks
> +    #   (d) Repeat till all tasks are mapped
> +    # Use placeholders to insure each sub-dict is instantiated
> +    def dep_sort_prep(self):
> +        self.progress_view.progress('DepSort',0,4)
> +        # Init the task base entries
> +        self.progress_view.progress('DepSort',1,4)
> +        dep_table =3D {}
> +        bb_index =3D 0
> +        for task in self.pkg_model:
> +            # First define the incoming bitbake sort order
> +            self.bb_sort_map[task] =3D "%04d" % (bb_index)
> +            bb_index +=3D 1
> +            task_group =3D task[0:task.find('.')]
> +            if task_group not in dep_table:
> +                dep_table[task_group] =3D {}
> +                dep_table[task_group]['-'] =3D {}         # Placeholder
> +            if task not in dep_table[task_group]:
> +                dep_table[task_group][task] =3D {}
> +                dep_table[task_group][task]['-'] =3D {}   # Placeholder
> +        # Add the task dependecy entries
> +        self.progress_view.progress('DepSort',2,4)
> +        for task_obj in self.depends_model:
> +            if task_obj[DEPENDS_TYPE] !=3D TYPE_DEP:
> +                continue
> +            task =3D task_obj[DEPENDS_TASK]
> +            task_dep =3D task_obj[DEPENDS_DEPS]
> +            task_group =3D task[0:task.find('.')]
> +            # Only track depends within same group
> +            if task_dep.startswith(task_group+'.'):
> +                dep_table[task_group][task][task_dep] =3D 1
> +        self.progress_view.progress('DepSort',3,4)
> +        for task_group in dep_table:
> +            dep_index =3D 0
> +            # Whittle down the tasks of each group
> +            this_pass =3D 1
> +            do_loop =3D True
> +            while (len(dep_table[task_group]) > 1) and do_loop:
> +                this_pass +=3D 1
> +                is_change =3D False
> +                delete_list =3D []
> +                for task in dep_table[task_group]:
> +                    if '-' =3D=3D task:
> +                        continue
> +                    if 1 =3D=3D len(dep_table[task_group][task]):
> +                        is_change =3D True
> +                        # No more deps, so collect this task...
> +                        self.dep_sort_map[task] =3D "%s_%04d" %
> (task_group,dep_index)
> +                        dep_index +=3D 1
> +                        # ... remove it from other lists as resolved ...
> +                        for dep_task in dep_table[task_group]:
> +                            if task in dep_table[task_group][dep_task]:
> +                                del dep_table[task_group][dep_task][task=
]
> +                        # ... and remove it from from the task group
> +                        delete_list.append(task)
> +                for task in delete_list:
> +                    del dep_table[task_group][task]
> +                if not is_change:
> +                    alert("ERROR:DEP_SIEVE_NO_CHANGE:%s" %
> task_group,self.screen)
> +                    _log("ERROR:DEP_SIEVE_NO_CHANGE:%s,%s" %
> (str(dep_table[task_group])))
> +                    do_loop =3D False
> +                    continue
> +        self.progress_view.progress('',4,4)
> +        self.progress_view.clear()
> +        self.help_bar_view.show_help(True)
> +        if len(self.dep_sort_map) !=3D len(self.pkg_model):
> +            alert("ErrorDepSort:%d/%d" %
> (len(self.dep_sort_map),len(self.pkg_model)),self.screen)
> +
> +    # Look up a dep sort order key
> +    def get_dep_sort(self,key):
> +        if key in self.dep_sort_map:
> +            return(self.dep_sort_map[key])
> +        else:
> +            return(key)
> +
> +    # Look up a bitbake sort order key
> +    def get_bb_sort(self,key):
> +        if key in self.bb_sort_map:
> +            return(self.bb_sort_map[key])
> +        else:
> +            return(key)
> +
> +    # Find the selected package in the main frame, update the dependency
> frames content accordingly
> +    def select(self, package_name, only_update_dependents=3DFalse):
> +        if not package_name:
> +            package_name =3D self.package_view.get_selected()
> +        # alert("SELECT:%s:" % package_name,self.screen)
> +
> +        if self.filter_str !=3D self.filter_prev:
> +            self.package_view.cursor_on(False)
> +            # Fill of the main package task list using new filter
> +            self.package_view.task_list =3D []
> +            for package in self.pkg_model:
> +                if self.filter_str:
> +                    if self.filter_str in package:
> +                        self.package_view.task_list_append(package,self)
> +                else:
> +                    self.package_view.task_list_append(package,self)
> +            self.package_view.sort()
> +            self.filter_prev =3D self.filter_str
> +
> +            # Old position is lost, assert new position of previous task
> (if still filtered in)
> +            self.package_view.cursor_index =3D 0
> +            self.package_view.cursor_offset =3D 0
> +            self.package_view.scroll_offset =3D 0
> +            self.package_view.redraw()
> +            self.package_view.cursor_on(True)
> +
> +        # Make sure the selected package is in view, with implicit
> redraw()
> +        if (not only_update_dependents):
> +            self.package_view.find(package_name)
> +        # In case selected name change (i.e. filter removed previous)
> +        package_name =3D self.package_view.get_selected()
> +
> +        # Filter the package's dependent list to the dependent view
> +        self.dep_view.reset()
> +        for package_def in self.depends_model:
> +            if (package_def[DEPENDS_TYPE] =3D=3D TYPE_DEP) and
> (package_def[DEPENDS_TASK] =3D=3D package_name):
> +
> self.dep_view.task_list_append(package_def[DEPENDS_DEPS],self)
> +        self.dep_view.sort()
> +        self.dep_view.redraw()
> +        # Filter the package's dependent list to the reverse dependent
> view
> +        self.reverse_view.reset()
> +        for package_def in self.depends_model:
> +            if (package_def[DEPENDS_TYPE] =3D=3D TYPE_RDEP) and
> (package_def[DEPENDS_TASK] =3D=3D package_name):
> +
> self.reverse_view.task_list_append(package_def[DEPENDS_DEPS],self)
> +        self.reverse_view.sort()
> +        self.reverse_view.redraw()
> +        self.show_selected(package_name)
> +        self.screen.refresh()
> +
> +    # The print-to-file method
> +    def print_deps(self,whole_group=3DFalse):
> +        global is_printed
> +        # Print the selected deptree(s) to a file
> +        if not is_printed:
> +            try:
> +                # Move to backup any exiting file before first write
> +                if os.path.isfile(print_file_name):
> +                    os.system('mv -f %s %s' %
> (print_file_name,print_file_backup_name))
> +            except Exception as e:
> +                alert(e,self.screen)
> +                alert('',self.screen)
> +        print_list =3D []
> +        selected_task =3D self.package_view.get_selected()
> +        if not selected_task:
> +            return
> +        if not whole_group:
> +            print_list.append(selected_task)
> +        else:
> +            # Use the presorted task_group order from 'package_view'
> +            task_group =3D selected_task[0:selected_task.find('.')+1]
> +            for task_obj in self.package_view.task_list:
> +                task =3D task_obj[TASK_NAME]
> +                if task.startswith(task_group):
> +                    print_list.append(task)
> +        with open(print_file_name, "a") as fd:
> +            print_max =3D len(print_list)
> +            print_count =3D 1
> +            self.progress_view.progress('Write "%s"' %
> print_file_name,0,print_max)
> +            for task in print_list:
> +                print_count =3D
> self.progress_view.progress('',print_count,print_max)
> +                self.select(task)
> +                self.screen.refresh();
> +                # Utilize the current print output model
> +                if print_model =3D=3D PRINT_MODEL_1:
> +                    print("=3D=3D=3D Dependendency Snapshot =3D=3D=3D",f=
ile=3Dfd)
> +                    print(" =3D Package =3D",file=3Dfd)
> +                    print('   '+task,file=3Dfd)
> +                    # Fill in the matching dependencies
> +                    print(" =3D Dependencies =3D",file=3Dfd)
> +                    for task_obj in self.dep_view.task_list:
> +                        print('   '+ task_obj[TASK_NAME],file=3Dfd)
> +                    print(" =3D Dependent Tasks =3D",file=3Dfd)
> +                    for task_obj in self.reverse_view.task_list:
> +                        print('   '+ task_obj[TASK_NAME],file=3Dfd)
> +                if print_model =3D=3D PRINT_MODEL_2:
> +                    print("=3D=3D=3D Dependendency Snapshot =3D=3D=3D",f=
ile=3Dfd)
> +                    dep_count =3D len(self.dep_view.task_list) - 1
> +                    for i,task_obj in enumerate(self.dep_view.task_list)=
:
> +                        print('%s%s' % ("Dep    =3D" if (i=3D=3Ddep_coun=
t) else
> "        ",task_obj[TASK_NAME]),file=3Dfd)
> +                    if not self.dep_view.task_list:
> +                        print('Dep    =3D',file=3Dfd)
> +                    print("Package=3D%s" % task,file=3Dfd)
> +                    for i,task_obj in
> enumerate(self.reverse_view.task_list):
> +                        print('%s%s' % ("RDep   =3D" if (i=3D=3D0) else =
"
> ",task_obj[TASK_NAME]),file=3Dfd)
> +                    if not self.reverse_view.task_list:
> +                        print('RDep   =3D',file=3Dfd)
> +                curses.napms(2000)
> +                self.progress_view.clear()
> +                self.help_bar_view.show_help(True)
> +            print('',file=3Dfd)
> +        # Restore display to original selected task
> +        self.select(selected_task)
> +        is_printed =3D True
> +
> +
> +#################################################
> +### main
> +###
> +
> +SCREEN_COL_MIN =3D 83
> +SCREEN_ROW_MIN =3D 26
> +
> +def main(server, eventHandler, params):
> +    global verbose
> +    global sort_model
> +    global print_model
> +    global is_printed
> +    global is_filter
> +    global screen_too_small
> +
> +    shutdown =3D 0
> +    screen_too_small =3D False
> +    quit =3D False
> +
> +    # Help method to dynamically test parent window too small
> +    def check_screen_size(dep, active_package):
> +        global screen_too_small
> +        rows, cols =3D screen.getmaxyx()
> +        if (rows >=3D SCREEN_ROW_MIN) and (cols >=3D SCREEN_COL_MIN):
> +            if screen_too_small:
> +                # Now big enough, remove error message and redraw screen
> +                dep.draw_frames()
> +                active_package.cursor_on(True)
> +                screen_too_small =3D False
> +            return True
> +        # Test on App init
> +        if not dep:
> +            # Do not start this app if screen not big enough
> +            curses.endwin()
> +            print("")
> +            print("ERROR(Taskexp_cli): Mininal screen size is %dx%d" %
> (SCREEN_COL_MIN,SCREEN_ROW_MIN))
> +            print("Current screen is Cols=3D%s,Rows=3D%d" % (cols,rows))
> +            return False
> +        # First time window too small
> +        if not screen_too_small:
> +            active_package.cursor_on(False)
> +            dep.screen.addstr(0,2,'[BIGGER WINDOW PLEASE]',
> curses.color_pair(CURSES_WARNING) | curses.A_BLINK)
> +            screen_too_small =3D True
> +        return False
> +
> +    # Helper method to turn off curses mode
> +    def curses_off(screen):
> +        # Safe error exit
> +        screen.keypad(False)
> +        curses.echo()
> +        curses.curs_set(1)
> +        curses.endwin()
> +
> +        if unit_test_results:
> +            print('\nUnit Test Results:')
> +            for line in unit_test_results:
> +                print(" %s" % line)
> +
> +    #
> +    # Initialize the ncurse environment
> +    #
> +
> +    screen =3D curses.initscr()
> +    try:
> +        if not check_screen_size(None, None):
> +            exit(1)
> +        try:
> +            curses.start_color()
> +            curses.use_default_colors();
> +            curses.init_pair(0xFF, curses.COLOR_BLACK,
> curses.COLOR_WHITE);
> +            curses.init_pair(CURSES_NORMAL, curses.COLOR_WHITE,
> curses.COLOR_BLACK)
> +            curses.init_pair(CURSES_HIGHLIGHT, curses.COLOR_WHITE,
> curses.COLOR_BLUE)
> +            curses.init_pair(CURSES_WARNING, curses.COLOR_WHITE,
> curses.COLOR_RED)
> +        except:
> +            curses.endwin()
> +            print("")
> +            print("ERROR(Taskexp_cli): Requires 256 colors. Please use
> this or the equivalent:")
> +            print("  $ export TERM=3D'xterm-256color'")
> +            exit(1)
> +
> +        screen.keypad(True)
> +        curses.noecho()
> +        curses.curs_set(0)
> +        screen.refresh();
> +    except Exception as e:
> +        # Safe error exit
> +        curses_off(screen)
> +        print("Exception : %s" % e)
> +        print("Exception in startup:\n %s" % traceback.format_exc())
> +        exit(1)
> +
> +    #
> +    # Instantiate the presentation layer
> +    #
> +
> +    dep =3D DepExplorer(screen)
> +
> +    #
> +    # Main bitbake loop
> +    #
> +
> +    try:
> +        params.updateToServer(server, os.environ.copy())
> +        params.updateFromServer(server)
> +        cmdline =3D params.parseActions()
> +        if not cmdline:
> +            curses_off(screen)
> +            print("ERROR: nothing to do.  Use 'bitbake world' to build
> everything, or run 'bitbake --help' for usage information.")
> +            return 1
> +        if 'msg' in cmdline and cmdline['msg']:
> +            curses_off(screen)
> +            print('ERROR: ' + cmdline['msg'])
> +            return 1
> +        cmdline =3D cmdline['action']
> +        if not cmdline or cmdline[0] !=3D "generateDotGraph":
> +            curses_off(screen)
> +            print("ERROR: This UI requires the -g option")
> +            return 1
> +        ret, error =3D server.runCommand(["generateDepTreeEvent",
> cmdline[1], cmdline[2]])
> +        if error:
> +            curses_off(screen)
> +            print("ERROR: running command '%s': %s" % (cmdline, error))
> +            return 1
> +        elif not ret:
> +            curses_off(screen)
> +            print("ERROR: running command '%s': returned %s" % (cmdline,
> ret))
> +            return 1
> +    except client.Fault as x:
> +        curses_off(screen)
> +        print("ERROR: XMLRPC Fault getting commandline:\n %s" % x)
> +        return 1
> +    except Exception as e:
> +        curses_off(screen)
> +        print("ERROR: in startup:\n %s" % traceback.format_exc())
> +        return 1
> +
> +    # Prepare to receive the data from bitbake
> +    progress_total =3D 0
> +    load_bitbake =3D True
> +    # Cmdline example =3D ['generateDotGraph', ['acl', 'zlib'], 'build']
> +    primary_packages =3D cmdline[1]
> +    dep.package_view.set_primary(primary_packages)
> +    dep.dep_view.set_primary(primary_packages)
> +    dep.reverse_view.set_primary(primary_packages)
> +    dep.help_box_view.set_primary(primary_packages)
> +    if unit_test:
> +        alert('UNIT_TEST',screen)
> +
> +    # Catch any errors and safely display them out of ncursor mode
> +    try:
> +        while load_bitbake:
> +            try:
> +                event =3D eventHandler.waitEvent(0.25)
> +                if quit:
> +                    _, error =3D server.runCommand(["stateForceShutdown"=
])
> +                    curses_off(screen)
> +                    if error:
> +                        print('Unable to cleanly stop: %s' % error)
> +                    break
> +
> +                if event is None:
> +                    continue
> +
> +                if isinstance(event, bb.event.CacheLoadStarted):
> +                    progress_total =3D event.total
> +                    dep.progress_view.progress('Loading
> Cache',0,progress_total)
> +                    continue
> +
> +                if isinstance(event, bb.event.CacheLoadProgress):
> +                    x =3D event.current
> +                    dep.progress_view.progress('',x,progress_total)
> +                    continue
> +
> +                if isinstance(event, bb.event.CacheLoadCompleted):
> +                    dep.progress_view.clear()
> +                    dep.progress_view.progress('Bitbake... ',1,2)
> +                    continue
> +
> +                if isinstance(event, bb.event.ParseStarted):
> +                    progress_total =3D event.total
> +                    if progress_total =3D=3D 0:
> +                        continue
> +                    dep.progress_view.progress('Processing
> recipes',0,progress_total)
> +
> +                if isinstance(event, bb.event.ParseProgress):
> +                    x =3D event.current
> +                    dep.progress_view.progress('',x,progress_total)
> +                    continue
> +
> +                if isinstance(event, bb.event.ParseCompleted):
> +                    dep.progress_view.progress('Generating dependency
> tree',0,3)
> +                    continue
> +
> +                if isinstance(event, bb.event.DepTreeGenerated):
> +                    dep.progress_view.progress('Generating dependency
> tree',1,3)
> +                    dep.parse(event._depgraph)
> +                    dep.progress_view.progress('Generating dependency
> tree',2,3)
> +
> +                if isinstance(event, bb.command.CommandCompleted):
> +                    load_bitbake =3D False
> +                    dep.progress_view.progress('Generating dependency
> tree',3,3)
> +                    dep.progress_view.clear()
> +                    dep.help_bar_view.show_help(True)
> +                    continue
> +
> +                if isinstance(event, bb.event.NoProvider):
> +                    curses_off(screen)
> +                    print('ERROR: %s' % event)
> +
> +                    _, error =3D server.runCommand(["stateShutdown"])
> +                    if error:
> +                        print('ERROR: Unable to cleanly shutdown: %s' %
> error)
> +                    return 1
> +
> +                if isinstance(event, bb.command.CommandFailed):
> +                    curses_off(screen)
> +                    print('ERROR: ' + str(event))
> +                    return event.exitcode
> +
> +                if isinstance(event, bb.command.CommandExit):
> +                    curses_off(screen)
> +                    return event.exitcode
> +
> +                if isinstance(event, bb.cooker.CookerExit):
> +                    break
> +
> +                continue
> +            except EnvironmentError as ioerror:
> +                # ignore interrupted io
> +                if ioerror.args[0] =3D=3D 4:
> +                    pass
> +            except KeyboardInterrupt:
> +                if shutdown =3D=3D 2:
> +                    curses_off(screen)
> +                    print("\nThird Keyboard Interrupt, exit.\n")
> +                    break
> +                if shutdown =3D=3D 1:
> +                    curses_off(screen)
> +                    print("\nSecond Keyboard Interrupt, stopping...\n")
> +                    _, error =3D server.runCommand(["stateForceShutdown"=
])
> +                    if error:
> +                        print('Unable to cleanly stop: %s' % error)
> +                if shutdown =3D=3D 0:
> +                    curses_off(screen)
> +                    print("\nKeyboard Interrupt, closing down...\n")
> +                    _, error =3D server.runCommand(["stateShutdown"])
> +                    if error:
> +                        print('Unable to cleanly shutdown: %s' % error)
> +                shutdown =3D shutdown + 1
> +                pass
> +
> +        #
> +        # Main user loop
> +        #
> +
> +        dep.help_bar_view.show_help(True)
> +        active_package =3D dep.package_view
> +        active_package.cursor_on(True)
> +        dep.select(primary_packages[0]+'.')
> +
> +        # Help method to start/stop the filter feature
> +        def filter_mode(new_filter_status):
> +            global is_filter
> +            if is_filter =3D=3D new_filter_status:
> +                # Ignore no changes
> +                return
> +            if not new_filter_status:
> +                # Turn off
> +                curses.curs_set(0)
> +                #active_package.cursor_on(False)
> +                active_package =3D dep.package_view
> +                active_package.cursor_on(True)
> +                is_filter =3D False
> +                dep.help_bar_view.show_help(True)
> +                dep.filter_str =3D ''
> +                dep.select('')
> +            else:
> +                # Turn on
> +                curses.curs_set(1)
> +                dep.help_bar_view.show_help(False)
> +                dep.filter_view.clear()
> +                dep.filter_view.show(True)
> +                dep.filter_view.show_prompt()
> +                is_filter =3D True
> +
> +        while not quit:
> +            if is_filter:
> +                dep.filter_view.show_prompt()
> +            if unit_test:
> +                c =3D unit_test_action(active_package)
> +            else:
> +                c =3D screen.getch()
> +            ch =3D chr(c)
> +
> +            # Do not draw if window now too small
> +            if not check_screen_size(dep,active_package):
> +                continue
> +
> +            if verbose:
> +                if c =3D=3D CHAR_RETURN:
> +                    screen.addstr(0, 4, "|%3d,CR |" % (c))
> +                else:
> +                    screen.addstr(0, 4, "|%3d,%3s|" % (c,chr(c)))
> +
> +            # pre-map alternate filter close keys
> +            if is_filter and (c =3D=3D CHAR_ESCAPE):
> +                # Alternate exit from filter
> +                ch =3D '/'
> +                c =3D ord(ch)
> +
> +            # Filter and non-filter mode command keys
> +            # https://docs.python.org/3/library/curses.html
> +            if c in (curses.KEY_UP,CHAR_UP):
> +                active_package.line_up()
> +                if active_package =3D=3D dep.package_view:
> +                    dep.select('',only_update_dependents=3DTrue)
> +            elif c in (curses.KEY_DOWN,CHAR_DOWN):
> +                active_package.line_down()
> +                if active_package =3D=3D dep.package_view:
> +                    dep.select('',only_update_dependents=3DTrue)
> +            elif curses.KEY_PPAGE =3D=3D c:
> +                active_package.page_up()
> +                if active_package =3D=3D dep.package_view:
> +                    dep.select('',only_update_dependents=3DTrue)
> +            elif curses.KEY_NPAGE =3D=3D c:
> +                active_package.page_down()
> +                if active_package =3D=3D dep.package_view:
> +                    dep.select('',only_update_dependents=3DTrue)
> +            elif CHAR_TAB =3D=3D c:
> +                # Tab between boxes
> +                active_package.cursor_on(False)
> +                if active_package =3D=3D dep.package_view:
> +                    active_package =3D dep.dep_view
> +                elif active_package =3D=3D dep.dep_view:
> +                    active_package =3D dep.reverse_view
> +                else:
> +                    active_package =3D dep.package_view
> +                active_package.cursor_on(True)
> +            elif curses.KEY_BTAB =3D=3D c:
> +                # Shift-Tab reverse between boxes
> +                active_package.cursor_on(False)
> +                if active_package =3D=3D dep.package_view:
> +                    active_package =3D dep.reverse_view
> +                elif active_package =3D=3D dep.reverse_view:
> +                    active_package =3D dep.dep_view
> +                else:
> +                    active_package =3D dep.package_view
> +                active_package.cursor_on(True)
> +            elif (CHAR_RETURN =3D=3D c):
> +                # CR to select
> +                selected =3D active_package.get_selected()
> +                if selected:
> +                    active_package.cursor_on(False)
> +                    active_package =3D dep.package_view
> +                    filter_mode(False)
> +                    dep.select(selected)
> +                else:
> +                    filter_mode(False)
> +                    dep.select(primary_packages[0]+'.')
> +
> +            elif '/' =3D=3D ch: # Enter/exit dep.filter_view
> +                if is_filter:
> +                    filter_mode(False)
> +                else:
> +                    filter_mode(True)
> +            elif is_filter:
> +                # If in filter mode, re-direct all these other keys to
> the filter box
> +                result =3D dep.filter_view.input(c,ch)
> +                dep.filter_str =3D dep.filter_view.filter_str
> +                dep.select('')
> +
> +            # Non-filter mode command keys
> +            elif 'p' =3D=3D ch:
> +                dep.print_deps(whole_group=3DFalse)
> +            elif 'P' =3D=3D ch:
> +                dep.print_deps(whole_group=3DTrue)
> +            elif 'w' =3D=3D ch:
> +                # Toggle the print model
> +                if print_model =3D=3D PRINT_MODEL_1:
> +                    print_model =3D PRINT_MODEL_2
> +                else:
> +                    print_model =3D PRINT_MODEL_1
> +            elif 's' =3D=3D ch:
> +                # Toggle the sort model
> +                if sort_model =3D=3D SORT_DEPS:
> +                    sort_model =3D SORT_ALPHA
> +                elif sort_model =3D=3D SORT_ALPHA:
> +                    if SORT_BITBAKE_ENABLE:
> +                        sort_model =3D TASK_SORT_BITBAKE
> +                    else:
> +                        sort_model =3D SORT_DEPS
> +                else:
> +                    sort_model =3D SORT_DEPS
> +                active_package.cursor_on(False)
> +                current_task =3D active_package.get_selected()
> +                dep.package_view.sort()
> +                dep.dep_view.sort()
> +                dep.reverse_view.sort()
> +                active_package =3D dep.package_view
> +                active_package.cursor_on(True)
> +                dep.select(current_task)
> +                # Announce the new sort model
> +                alert("SORT=3D%s" % ("ALPHA" if (sort_model =3D=3D SORT_=
ALPHA)
> else "DEPS"),screen)
> +                alert('',screen)
> +
> +            elif 'q' =3D=3D ch:
> +                quit =3D True
> +            elif ch in ('h','?'):
> +                dep.help_box_view.show_help(True)
> +                dep.select(active_package.get_selected())
> +
> +            #
> +            # Debugging commands
> +            #
> +
> +            elif 'V' =3D=3D ch:
> +                verbose =3D not verbose
> +                alert('Verbose=3D%s' % str(verbose),screen)
> +                alert('',screen)
> +            elif 'R' =3D=3D ch:
> +                screen.refresh()
> +            elif 'B' =3D=3D ch:
> +                # Progress bar unit test
> +                dep.progress_view.progress('Test',0,40)
> +                curses.napms(1000)
> +                dep.progress_view.progress('',10,40)
> +                curses.napms(1000)
> +                dep.progress_view.progress('',20,40)
> +                curses.napms(1000)
> +                dep.progress_view.progress('',30,40)
> +                curses.napms(1000)
> +                dep.progress_view.progress('',40,40)
> +                curses.napms(1000)
> +                dep.progress_view.clear()
> +                dep.help_bar_view.show_help(True)
> +            elif 'Q' =3D=3D ch:
> +                # Simulated error
> +                curses_off(screen)
> +                print('ERROR: simulated error exit')
> +                return 1
> +
> +        # Safe exit
> +        curses_off(screen)
> +    except Exception as e:
> +        # Safe exit on error
> +        curses_off(screen)
> +        print("Exception : %s" % e)
> +        print("Exception in startup:\n %s" % traceback.format_exc())
> +
> +    # Reminder to pick up your printed results
> +    if is_printed:
> +        print("")
> +        print("You have output ready!")
> +        print("  * Your printed dependency file is: %s" %
> print_file_name)
> +        print("  * Your previous results  saved in: %s" %
> print_file_backup_name)
> +        print("")
> --
> 2.35.1


