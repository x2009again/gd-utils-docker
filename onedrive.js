const process = require("child_process");


const { GD_root_Path, OneDrive_Path } = require('../config')

async function copy_to_onedrive(taskid,callback){
    process.exec(`rclone copy -P ${GD_root_Path} ${OneDrive_Path} --stats 5s -P --cache-chunk-size=100M --transfers=4 --ignore-errors > /root/.config/rclone/progress${taskid}.log`, (error, stdout, stderr) => {
        if (!error) {
          // 成功
          process.exec(`rm -f /root/.config/rclone/progress${taskid}.log`)
            callback(1);
        } else {
          // 失败
          callback(0);
          process.exec(`rm -f /root/.config/rclone/progress${taskid}.log && echo ${taskid} >> /root/.config/rclone/fail.log && echo '${stderr}' >> /root/.config/rclone/fail.log`)
        }
      });
}

module.exports ={copy_to_onedrive}