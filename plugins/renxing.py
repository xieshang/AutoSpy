Version = 1679378322
try:
    import asyncio
    from urllib import parse
    import random
    import aiohttp
    import json
    import re
    import datetime, time, json
    from auto_spy import client
    from telethon import events
    import yaml
    import re
    import os
except:
    import os
    import asyncio
    import aiohttp
    import re
    from auto_spy import client
    from telethon import events
    pass
from telethon.tl.types import ChannelForbidden


def lang(string):
    return string


class class_spy_api:
    async def api_id(self, context):
        """ Query the UserID of the sender of the message you replied to. """
        message = await context.get_reply_message()
        text = "Message ID: `" + str(context.message.id) + "`\n\n"
        text += "**Chat**\nid:`" + str(context.chat_id) + "`\n"
        msg_from = context.chat if context.chat else (await context.get_chat())
        if context.is_private:
            try:
                text += "first_name: `" + msg_from.first_name + "`\n"
            except TypeError:
                text += "**死号**\n"
            if msg_from.last_name:
                text += "last_name: `" + msg_from.last_name + "`\n"
            if msg_from.username:
                text += "username: @" + msg_from.username + "\n"
            if msg_from.lang_code:
                text += "lang_code: `" + msg_from.lang_code + "`\n"
        if context.is_group or context.is_channel:
            text += "title: `" + msg_from.title + "`\n"
            try:
                if msg_from.username:
                    text += "username: @" + msg_from.username + "\n"
            except AttributeError:
                await context.reply(lang('leave_not_group'))
                return
            text += "date: `" + str(msg_from.date) + "`\n"
        if message:
            text += "\n" + lang('id_hint') + "\nMessage ID: `" + str(message.id) + "`\n\n**User**\nid: `" + str(
                message.sender_id) + "`"
            try:
                if message.sender.bot:
                    text += f"\nis_bot: {lang('id_is_bot_yes')}"
                try:
                    text += "\nfirst_name: `" + message.sender.first_name + "`"
                except TypeError:
                    text += f"\n**{lang('id_da')}**"
                if message.sender.last_name:
                    text += "\nlast_name: `" + message.sender.last_name + "`"
                if message.sender.username:
                    text += "\nusername: @" + message.sender.username
                if message.sender.lang_code:
                    text += "\nlang_code: `" + message.sender.lang_code + "`"
            except AttributeError:
                pass
            if message.forward:
                if str(message.forward.chat_id).startswith('-100'):
                    text += "\n\n**Forward From Channel**\nid: `" + str(
                        message.forward.chat_id) + "`\ntitle: `" + message.forward.chat.title + "`"
                    if not isinstance(message.forward.chat, ChannelForbidden):
                        if message.forward.chat.username:
                            text += "\nusername: @" + message.forward.chat.username
                        text += "\nmessage_id: `" + str(message.forward.channel_post) + "`"
                        if message.forward.post_author:
                            text += "\npost_author: `" + message.forward.post_author + "`"
                        text += "\ndate: `" + str(message.forward.date) + "`"
                else:
                    if message.forward.sender:
                        text += "\n\n**Forward From User**\nid: `" + str(
                            message.forward.sender_id) + "`"
                        try:
                            if message.forward.sender.bot:
                                text += f"\nis_bot: {lang('id_is_bot_yes')}"
                            try:
                                text += "\nfirst_name: `" + message.forward.sender.first_name + "`"
                            except TypeError:
                                text += f"\n**{lang('id_da')}**"
                            if message.forward.sender.last_name:
                                text += "\nlast_name: `" + message.forward.sender.last_name + "`"
                            if message.forward.sender.username:
                                text += "\nusername: @" + message.forward.sender.username
                            if message.forward.sender.lang_code:
                                text += "\nlang_code: `" + message.forward.sender.lang_code + "`"
                        except AttributeError:
                            pass
                        text += "\ndate: `" + str(message.forward.date) + "`"
        await context.reply(text)

    async def api_re(self, context):
        """ Forwards a message into this group """
        reply = await context.get_reply_message()
        await context.delete()
        if reply:
            try:
                if context.arguments == '':
                    num = 1
                else:
                    try:
                        num = int(context.arguments)
                        if num > 100:
                            await context.reply(lang('re_too_big'))
                    except:
                        await context.reply(lang('re_arg_error'))
            except:
                num = 1
            try:
                for nums in range(0, num):
                    await reply.forward_to(int(context.chat_id))
            except:
                pass
        else:
            await context.reply(lang('not_reply'))

    async def api_dme(self, context):
        """ Deletes specific amount of messages you sent. """
        msgs = []
        count_buffer = 0
        try:
            parameter = context.text.split(" ")[1:]
        except:
            parameter = []
        if not len(parameter) == 1:
            if not context.reply_to_msg_id:
                await context.edit(lang('arg_error'))
                return
            async for msg in context.client.iter_messages(
                    context.chat_id,
                    from_user="me",
                    min_id=context.reply_to_msg_id,
            ):
                msgs.append(msg)
                count_buffer += 1
                if len(msgs) == 100:
                    await context.client.delete_messages(context.chat_id, msgs)
                    msgs = []
            if msgs:
                await context.client.delete_messages(context.chat_id, msgs)
            if count_buffer == 0:
                await context.delete()
                count_buffer += 1
        try:
            count = int(parameter[0])
            await context.delete()
        except ValueError:
            await context.edit(lang('arg_error'))
            return
        async for message in context.client.iter_messages(context.chat_id, from_user="me"):
            if count_buffer == count:
                break
            msgs.append(message)
            count_buffer += 1
            if len(msgs) == 100:
                await context.client.delete_messages(context.chat_id, msgs)
                msgs = []
        if msgs:
            await context.client.delete_messages(context.chat_id, msgs)

    async def api_help(self, context):
        ret = "目前支持指令如下:\n"
        for cmd in self.api_list:
            ret += f'.{cmd}\n'
        reply = await context.reply(ret)
        await asyncio.sleep(10)
        await reply.delete()
        await context.delete()

    def __init__(self):
        self.api_list = {
            "help": self.api_help,
            "id": self.api_id,
            "re": self.api_re,
            "dme": self.api_dme,
        }

